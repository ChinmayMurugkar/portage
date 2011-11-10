# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/clang/clang-3.0_rc3.ebuild,v 1.2 2011/11/10 14:01:41 voyageur Exp $

EAPI=3

RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit eutils multilib python

DESCRIPTION="C language family frontend for LLVM"
HOMEPAGE="http://clang.llvm.org/"
# Fetching LLVM as well: see http://llvm.org/bugs/show_bug.cgi?id=4840
SRC_URI="http://llvm.org/pre-releases/${PV/_rc*}/${PV/3.0_}/llvm-${PV/_}.src.tar.gz
	http://llvm.org/pre-releases/${PV/_rc*}/${PV/3.0_}/${P/_}.src.tar.gz"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug multitarget +static-analyzer +system-cxx-headers test"

DEPEND="static-analyzer? ( dev-lang/perl )"
RDEPEND="~sys-devel/llvm-${PV}[multitarget=]"

S=${WORKDIR}/llvm-${PV/_}.src

src_prepare() {
	rm -f "${S}"/tools/clang
	mv "${WORKDIR}"/clang-${PV/_}.src "${S}"/tools/clang || die "clang source directory move failed"

	# Same as llvm doc patches
	epatch "${FILESDIR}"/${PN}-2.7-fixdoc.patch

	# multilib-strict
	sed -e "/PROJ_headers/s#lib/clang#$(get_libdir)/clang#" \
		-i tools/clang/lib/Headers/Makefile \
		|| die "clang Makefile failed"
	# Fix cxx_include_root path for Gentoo
	epatch "${FILESDIR}"/${P/_*}-fix_cxx_include_root.patch
	# fix the static analyzer for in-tree install
	sed -e 's/import ScanView/from clang \0/'  \
		-i tools/clang/tools/scan-view/scan-view \
		|| die "scan-view sed failed"
	sed -e "/scanview.css\|sorttable.js/s#\$RealBin#${EPREFIX}/usr/share/${PN}#" \
		-i tools/clang/tools/scan-build/scan-build \
		|| die "scan-build sed failed"
	# Specify python version
	python_convert_shebangs 2 tools/clang/tools/scan-view/scan-view

	# From llvm src_prepare
	einfo "Fixing install dirs"
	sed -e 's,^PROJ_docsdir.*,PROJ_docsdir := $(PROJ_prefix)/share/doc/'${PF}, \
		-e 's,^PROJ_etcdir.*,PROJ_etcdir := '"${EPREFIX}"'/etc/llvm,' \
		-e 's,^PROJ_libdir.*,PROJ_libdir := $(PROJ_prefix)/'$(get_libdir)/llvm, \
		-i Makefile.config.in || die "Makefile.config sed failed"

	einfo "Fixing rpath and CFLAGS"
	sed -e 's,\$(RPATH) -Wl\,\$(\(ToolDir\|LibDir\)),$(RPATH) -Wl\,'"${EPREFIX}"/usr/$(get_libdir)/llvm, \
		-e '/OmitFramePointer/s/-fomit-frame-pointer//' \
		-i Makefile.rules || die "rpath sed failed"
}

src_configure() {
	local CONF_FLAGS="--enable-shared
		--with-optimize-option=
		$(use_enable !debug optimized)
		$(use_enable debug assertions)
		$(use_enable debug expensive-checks)"

	# Setup the search path to include the Prefix includes
	if use prefix ; then
		CONF_FLAGS="${CONF_FLAGS} \
			--with-c-include-dirs=${EPREFIX}/usr/include:/usr/include"
	fi

	if use multitarget; then
		CONF_FLAGS="${CONF_FLAGS} --enable-targets=all"
	else
		CONF_FLAGS="${CONF_FLAGS} --enable-targets=host-only"
	fi

	if use amd64; then
		CONF_FLAGS="${CONF_FLAGS} --enable-pic"
	fi

	if use system-cxx-headers; then
		# Try to get current gcc headers path
		local CXX_PATH=$(gcc-config -X| cut -d: -f1 | sed 's,/include/g++-v4$,,')
		CONF_FLAGS="${CONF_FLAGS} --with-c-include-dirs=/usr/include:${CXX_PATH}/include"
		CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-root=${CXX_PATH}/include/g++-v4"
		CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-arch=$CHOST"
		if has_multilib_profile; then
			CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-32bit-dir=32"
		fi
	fi

	econf ${CONF_FLAGS} || die "econf failed"
}

src_compile() {
	local COMPILE_TARGET
	if use test; then
		COMPILE_TARGET="all"
	else
		COMPILE_TARGET="clang-only"
	fi
	emake VERBOSE=1 KEEP_SYMBOLS=1 REQUIRES_RTTI=1 \
		${COMPILE_TARGET} || die "emake failed"
}

src_test() {
	cd "${S}"/test || die "cd failed"
	emake site.exp || die "updating llvm site.exp failed"

	cd "${S}"/tools/clang || die "cd clang failed"

	# Broken test always assuming i386 host with multilib gcc 4.6.0
	# http://llvm.org/bugs/show_bug.cgi?id=11094
	rm -f test/Driver/linux-ld.c

	echo ">>> Test phase [test]: ${CATEGORY}/${PF}"
	if ! emake -j1 VERBOSE=1 test; then
		has test $FEATURES && die "Make test failed. See above for details."
		has test $FEATURES || eerror "Make test failed. See above for details."
	fi
}

src_install() {
	cd "${S}"/tools/clang || die "cd clang failed"
	emake KEEP_SYMBOLS=1 DESTDIR="${D}" install || die "install failed"

	if use static-analyzer ; then
		dobin tools/scan-build/ccc-analyzer
		dosym ccc-analyzer /usr/bin/c++-analyzer
		dobin tools/scan-build/scan-build

		insinto /usr/share/${PN}
		doins tools/scan-build/scanview.css
		doins tools/scan-build/sorttable.js

		cd tools/scan-view || die "cd scan-view failed"
		dobin scan-view
		install-scan-view() {
			insinto "$(python_get_sitedir)"/clang
			doins Reporter.py Resources ScanView.py startfile.py
			touch "${ED}"/"$(python_get_sitedir)"/clang/__init__.py
		}
		python_execute_function install-scan-view
	fi

	# Fix install_names on Darwin.  The build system is too complicated
	# to just fix this, so we correct it post-install
	if [[ ${CHOST} == *-darwin* ]] ; then
		for lib in libclang.dylib ; do
			ebegin "fixing install_name of $lib"
			install_name_tool -id "${EPREFIX}"/usr/lib/llvm/${lib} \
				"${ED}"/usr/lib/llvm/${lib}
			eend $?
		done
		for f in usr/bin/{c-index-test,clang} usr/lib/llvm/libclang.dylib ; do
			ebegin "fixing references in ${f##*/}"
			install_name_tool \
				-change "@rpath/libclang.dylib" \
					"${EPREFIX}"/usr/lib/llvm/libclang.dylib \
				-change "@executable_path/../lib/libLLVM-${PV}.dylib" \
					"${EPREFIX}"/usr/lib/llvm/libLLVM-${PV}.dylib \
				-change "${S}"/Release/lib/libclang.dylib \
					"${EPREFIX}"/usr/lib/llvm/libclang.dylib \
				"${ED}"/$f
			eend $?
		done
	fi
}

pkg_postinst() {
	python_mod_optimize clang
	if use system-cxx-headers; then
		elog "C++ headers search path is hardcoded to the active gcc profile one"
		elog "If you change the active gcc profile, or update gcc to a new version,"
		elog "you will have to remerge this package to update the search path"
	else
		elog "If clang++ fails to find C++ headers on your system,"
		elog "you can remerge clang with USE=system-cxx-headers to use C++ headers"
		elog "from the active gcc profile"
	fi
}

pkg_postrm() {
	python_mod_cleanup clang
}
