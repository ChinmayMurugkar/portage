# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-9999.ebuild,v 1.55 2012/08/04 19:57:41 zmedico Exp $

EAPI=3
inherit git-2 eutils multilib python

DESCRIPTION="Portage is the package management and distribution system for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="build doc epydoc +ipc pypy1_9 python2 python3 selinux xattr"

# Import of the io module in python-2.6 raises ImportError for the
# thread module if threading is disabled.
python_dep_ssl="python3? ( =dev-lang/python-3*[ssl] )
	!pypy1_9? ( !python2? ( !python3? (
		|| ( >=dev-lang/python-2.7[ssl] dev-lang/python:2.6[threads,ssl] )
	) ) )
	pypy1_9? ( !python2? ( !python3? ( dev-python/pypy:1.9[bzip2,ssl] ) ) )
	python2? ( !python3? ( || ( dev-lang/python:2.7[ssl] dev-lang/python:2.6[ssl,threads] ) ) )"
python_dep="${python_dep_ssl//\[ssl\]}"
python_dep="${python_dep//,ssl}"
python_dep="${python_dep//ssl,}"

# The pysqlite blocker is for bug #282760.
DEPEND="${python_dep}
	>=sys-apps/sed-4.0.5 sys-devel/patch
	doc? ( app-text/xmlto ~app-text/docbook-xml-dtd-4.4 )
	epydoc? ( >=dev-python/epydoc-2.0 !<=dev-python/pysqlite-2.4.1 )"
# Require sandbox-2.2 for bug #288863.
# For xattr, we can spawn getfattr and setfattr from sys-apps/attr, but that's
# quite slow, so it's not considered in the dependencies as an alternative to
# to python-3.3 / pyxattr. Also, xattr support is only tested with Linux, so
# for now, don't pull in xattr deps for other kernels.
# For whirlpool hash, require python[ssl] or python-mhash (bug #425046).
RDEPEND="${python_dep}
	!build? ( >=sys-apps/sed-4.0.5
		>=app-shells/bash-3.2_p17
		>=app-admin/eselect-1.2
		|| ( ${python_dep_ssl} dev-python/python-mhash )
	)
	elibc_FreeBSD? ( sys-freebsd/freebsd-bin )
	elibc_glibc? ( >=sys-apps/sandbox-2.2 )
	elibc_uclibc? ( >=sys-apps/sandbox-2.2 )
	>=app-misc/pax-utils-0.1.17
	xattr? ( kernel_linux? ( || ( >=dev-lang/python-3.3_pre20110902 dev-python/pyxattr ) ) )
	selinux? ( || ( >=sys-libs/libselinux-2.0.94[python] <sys-libs/libselinux-2.0.94 ) )
	!<app-shells/bash-3.2_p17
	!<app-admin/logrotate-3.8.0"
PDEPEND="
	!build? (
		>=net-misc/rsync-2.6.4
		userland_GNU? ( >=sys-apps/coreutils-6.4 )
	)"
# coreutils-6.4 rdep is for date format in emerge-webrsync #164532
# NOTE: FEATURES=install-sources requires debugedit and rsync

SRC_ARCHIVES="http://dev.gentoo.org/~zmedico/portage/archives"

prefix_src_archives() {
	local x y
	for x in ${@}; do
		for y in ${SRC_ARCHIVES}; do
			echo ${y}/${x}
		done
	done
}

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/portage.git"
S="${WORKDIR}"/${PN}

compatible_python_is_selected() {
	[[ $("${EPREFIX}/usr/bin/python" -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x2060000 and "good" or "bad")') = good ]]
}

current_python_has_xattr() {
	[[ $("${EPREFIX}/usr/bin/python" -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x3030000 and "yes" or "no")') = yes ]] || \
	"${EPREFIX}/usr/bin/python" -c 'import xattr' 2>/dev/null
}

pkg_setup() {
	# Bug #359731 - Die early if get_libdir fails.
	[[ -z $(get_libdir) ]] && \
		die "get_libdir returned an empty string"

	if use python2 && use python3 ; then
		ewarn "Both python2 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy1_9 && use python3 ; then
		ewarn "Both pypy1_9 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy1_9 && use python2 ; then
		ewarn "Both pypy1_9 and python2 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python2"
	fi
	if ! use pypy1_9 && ! use python2 && ! use python3 && \
		! compatible_python_is_selected ; then
		ewarn "Attempting to select a compatible default python interpreter"
		local x success=0
		for x in /usr/bin/python2.* ; do
			x=${x#/usr/bin/python2.}
			if [[ $x -ge 6 ]] 2>/dev/null ; then
				eselect python set python2.$x
				if compatible_python_is_selected ; then
					elog "Default python interpreter is now set to python-2.$x"
					success=1
					break
				fi
			fi
		done
		if [ $success != 1 ] ; then
			eerror "Unable to select a compatible default python interpreter!"
			die "This version of portage requires at least python-2.6 to be selected as the default python interpreter (see \`eselect python --help\`)."
		fi
	fi

	if use python3; then
		python_set_active_version 3
	elif use python2; then
		python_set_active_version 2
	elif use pypy1_9; then
		python_set_active_version 2.7-pypy-1.9
	fi
}

src_prepare() {
	epatch_user

	einfo "Producing ChangeLog from Git history..."
	pushd "${S}/.git" >/dev/null || die
	git log ebcf8975b37a8aae9735eb491a9b4cb63549bd5d^.. \
		> "${S}"/ChangeLog || die
	popd >/dev/null || die

	local _version=$(cd "${S}/.git" && git describe --tags | sed -e 's|-\([0-9]\+\)-.\+$|_p\1|')
	_version=${_version:1}
	einfo "Setting portage.VERSION to ${_version} ..."
	sed -e "s/^VERSION=.*/VERSION='${_version}'/" -i pym/portage/__init__.py || \
		die "Failed to patch portage.VERSION"
	sed -e "1s/VERSION/${_version}/" -i doc/fragment/version || \
		die "Failed to patch VERSION in doc/fragment/version"
	sed -e "1s/VERSION/${_version}/" -i man/* || \
		die "Failed to patch VERSION in man page headers"

	if ! use ipc ; then
		einfo "Disabling ipc..."
		sed -e "s:_enable_ipc_daemon = True:_enable_ipc_daemon = False:" \
			-i pym/_emerge/AbstractEbuildProcess.py || \
			die "failed to patch AbstractEbuildProcess.py"
	fi

	if use xattr && use kernel_linux ; then
		einfo "Adding FEATURES=xattr to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} xattr"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
	fi

	if use python3; then
		einfo "Converting shebangs for python3..."
		python_convert_shebangs -r 3 .
	elif use python2; then
		einfo "Converting shebangs for python2..."
		python_convert_shebangs -r 2 .
	elif use pypy1_9; then
		einfo "Converting shebangs for pypy-c1.9..."
		python_convert_shebangs -r 2.7-pypy-1.9 .
	fi

	if [[ -n ${EPREFIX} ]] ; then
		einfo "Setting portage.const.EPREFIX ..."
		sed -e "s|^\(SANDBOX_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/bin/sandbox\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(FAKEROOT_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/bin/fakeroot\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(BASH_BINARY[[:space:]]*=[[:space:]]*\"\)\(/bin/bash\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(MOVE_BINARY[[:space:]]*=[[:space:]]*\"\)\(/bin/mv\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(PRELINK_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/sbin/prelink\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(EPREFIX[[:space:]]*=[[:space:]]*\"\).*|\\1${EPREFIX}\"|" \
			-i pym/portage/const.py || \
			die "Failed to patch portage.const.EPREFIX"

		einfo "Prefixing shebangs ..."
		find . -type f -print0 | \
		while read -r -d $'\0' ; do
			local shebang=$(head -n1 "$REPLY")
			if [[ ${shebang} == "#!"* && ! ${shebang} == "#!${EPREFIX}/"* ]] ; then
				sed -i -e "1s:.*:#!${EPREFIX}${shebang:2}:" "$REPLY" || \
					die "sed failed"
			fi
		done

		einfo "Adjusting make.globals ..."
		sed -e 's|^SYNC=.*|SYNC="rsync://rsync.prefix.freens.org/gentoo-portage-prefix"|' \
			-e "s|^\(PORTDIR=\)\(/usr/portage\)|\\1\"${EPREFIX}\\2\"|" \
			-e "s|^\(PORTAGE_TMPDIR=\)\(/var/tmp\)|\\1\"${EPREFIX}\\2\"|" \
			-i cnf/make.globals || die "sed failed"

		einfo "Adding FEATURES=force-prefix to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} force-prefix"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
	fi

	cd "${S}/cnf" || die
	if [ -f "make.conf.${ARCH}".diff ]; then
		patch make.conf "make.conf.${ARCH}".diff || \
			die "Failed to patch make.conf.example"
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
	fi

	# BSD and OSX need a sed wrapper so that find/xargs work properly
	if use userland_GNU; then
		rm -f "${S}"/bin/ebuild-helpers/sed || \
			die "Failed to remove sed wrapper"
	fi
}

src_compile() {
	if use doc; then
		emake docbook || die
	fi

	if use epydoc; then
		einfo "Generating api docs"
		emake epydoc || die
	fi
}

src_test() {
	./runtests.sh || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" \
		sysconfdir="${EPREFIX}/etc" \
		prefix="${EPREFIX}/usr" \
		libdir="${EPREFIX}/usr/$(get_libdir)" \
		install || die

	# Use dodoc for compression, since the Makefile doesn't do that.
	dodoc "${S}"/{ChangeLog,NEWS,RELEASE-NOTES} || die
}

pkg_preinst() {
	if [[ $ROOT == / ]] ; then
		# Run some minimal tests as a sanity check.
		local test_runner=$(find "${ED}" -name runTests)
		if [[ -n $test_runner && -x $test_runner ]] ; then
			einfo "Running preinst sanity tests..."
			"$test_runner" || die "preinst sanity tests failed"
		fi
	fi

	if use xattr && ! current_python_has_xattr ; then
		ewarn "For optimal performance in xattr handling, install"
		ewarn "dev-python/pyxattr, or install >=dev-lang/python-3.3 and"
		ewarn "enable USE=python3 for $CATEGORY/$PN."
	fi

	if ! use build && ! has_version dev-python/pycrypto && \
		! has_version '>=dev-lang/python-2.6[ssl]' ; then
		ewarn "If you are an ebuild developer and you plan to commit ebuilds"
		ewarn "with this system then please install dev-python/pycrypto or"
		ewarn "enable the ssl USE flag for >=dev-lang/python-2.6 in order"
		ewarn "to enable RMD160 hash support."
		ewarn "See bug #198398 for more information."
	fi

	has_version "<=${CATEGORY}/${PN}-2.2_pre5" \
		&& WORLD_MIGRATION_UPGRADE=true || WORLD_MIGRATION_UPGRADE=false

	# If portage-2.1.6 is installed and the preserved_libs_registry exists,
	# assume that the NEEDED.ELF.2 files have already been generated.
	has_version "<=${CATEGORY}/${PN}-2.2_pre7" && \
		! ( [ -e "${EROOT}"var/lib/portage/preserved_libs_registry ] && \
		has_version ">=${CATEGORY}/${PN}-2.1.6_rc" ) \
		&& NEEDED_REBUILD_UPGRADE=true || NEEDED_REBUILD_UPGRADE=false
}

pkg_postinst() {
	# Compile all source files recursively. Any orphans
	# will be identified and removed in postrm.
	python_mod_optimize /usr/$(get_libdir)/portage/pym

	if $WORLD_MIGRATION_UPGRADE && \
		grep -q "^@" "${EROOT}/var/lib/portage/world"; then
		einfo "moving set references from the worldfile into world_sets"
		cd "${EROOT}/var/lib/portage/"
		grep "^@" world >> world_sets
		sed -i -e '/^@/d' world
	fi

	if $NEEDED_REBUILD_UPGRADE ; then
		einfo "rebuilding NEEDED.ELF.2 files"
		for cpv in "${EROOT}/var/db/pkg"/*/*; do
			if [ -f "${cpv}/NEEDED" ]; then
				rm -f "${cpv}/NEEDED.ELF.2"
				while read line; do
					filename=${line% *}
					needed=${line#* }
					needed=${needed//+/++}
					needed=${needed//#/##}
					needed=${needed//%/%%}
					newline=$(scanelf -BF "%a;%F;%S;%r;${needed}" $filename)
					newline=${newline//  -  }
					echo "${newline:3}" >> "${cpv}/NEEDED.ELF.2"
				done < "${cpv}/NEEDED"
			fi
		done
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/portage/pym
}
