# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.16.ebuild,v 1.1 2012/07/04 09:10:05 patrick Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit waf-utils python

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/python-2.4.2
	>=sys-libs/talloc-2.0.6[python]"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

WAF_BINARY="${S}/buildtools/bin/waf"
PATCHES=( "${FILESDIR}"/add-py-file.patch )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	waf-utils_src_install
	insinto $(python_get_sitedir)
	doins tevent.py
}

pkg_postinst() {
	python_mod_optimize tevent.py
}

pkg_postrm() {
	python_mod_cleanup tevent.py
}
