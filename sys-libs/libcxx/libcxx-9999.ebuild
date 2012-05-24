# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcxx/libcxx-9999.ebuild,v 1.1 2012/05/24 03:01:42 aballier Exp $

EAPI=4

ESVN_REPO_URI="http://llvm.org/svn/llvm-project/libcxx/trunk"

[ "${PV%9999}" != "${PV}" ] && SCM="subversion" || SCM=""

inherit cmake-utils ${SCM} base

DESCRIPTION="New implementation of the C++ standard library, targeting C++0X"
HOMEPAGE="http://libcxx.llvm.org/"
if [ "${PV%9999}" = "${PV}" ] ; then
	SRC_URI="mirror://gentoo/${P}.tar.xz"
else
	SRC_URI=""
fi

LICENSE="|| ( UoI-NCSA MIT )"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64"
else
	KEYWORDS=""
fi
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/clang
	app-arch/xz-utils"

PATCHES=( "${FILESDIR}/multilib.patch" )
DOCS=( "CREDITS.TXT" )

src_prepare() {
	base_src_prepare
}

src_configure() {
	# Needs to be built with clang. gcc-4.6.3 fails at least.
	# TODO: cross-compile ?
	export CC=clang
	export CXX=clang++
	cmake-utils_src_configure
}

# Tests fail for now, if anybody is able to fix them, help is very welcome.
src_test() {
	cd "${S}/test"
	LD_LIBRARY_PATH="${CMAKE_BUILD_DIR}/lib:${LD_LIBRARY_PATH}" \
		CC="clang++" \
		HEADER_INCLUDE="-I${S}/include" \
		SOURCE_LIB="-L${CMAKE_BUILD_DIR}/lib" \
		./testit || die
}

pkg_postinst() {
	elog "This package (${PN}) is mainly intended as a replacement for the C++"
	elog "standard library when using clang."
	elog "To use it, instead of libstdc++, use:"
	elog "    clang++ -stdlib=libc++"
	elog "to compile your C++ programs."
}
