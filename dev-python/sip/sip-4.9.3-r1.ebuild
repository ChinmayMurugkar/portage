# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.9.3-r1.ebuild,v 1.1 2009/12/20 10:53:01 grobian Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit python toolchain-funcs eutils

MY_P=${P/_pre/-snapshot-}

DESCRIPTION="A tool for generating bindings for C++ classes so that they can be used by Python"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/sip/intro http://pypi.python.org/pypi/SIP"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/${PN}${PV%%.*}/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 sip )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc"

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-darwin.patch
	python_copy_sources
}

src_configure() {
	configuration() {
		local myconf="$(PYTHON) configure.py
				--bindir=${EPREFIX}/usr/bin
				--destdir=${EPREFIX}$(python_get_sitedir)
				--incdir=${EPREFIX}$(python_get_includedir)
				--sipdir=${EPREFIX}/usr/share/sip
				$(use debug && echo '--debug')
				CC=$(tc-getCC) CXX=$(tc-getCXX)
				LINK=$(tc-getCXX) LINK_SHLIB=$(tc-getCXX)
				CFLAGS='${CFLAGS}' CXXFLAGS='${CXXFLAGS}'
				LFLAGS='${LDFLAGS}'
				STRIP=true"
		echo ${myconf}
		eval ${myconf}
	}
	python_execute_function -s configuration
}

src_compile() {
	python_execute_function -d -s
}

src_install() {
	python_need_rebuild

	python_execute_function -d -s

	dodoc ChangeLog NEWS || die

	if use doc; then
		dohtml -r doc/html/* || die
	fi
}

pkg_postinst() {
	python_mod_optimize sipconfig.py sipdistutils.py

	ewarn 'When updating sip, you usually need to recompile packages that'
	ewarn 'depend on sip, such as PyQt4 and qscintilla-python. If you have'
	ewarn 'app-portage/gentoolkit installed you can find these packages with'
	ewarn '`equery d sip` and `equery d PyQt4`.'
}

pkg_postrm() {
	python_mod_cleanup sipconfig.py sipdistutils.py
}
