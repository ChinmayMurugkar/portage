# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-additional/ibus-table-additional-1.2.0.20090904.ebuild,v 1.2 2009/09/07 23:52:13 matsuu Exp $

EAPI="2"

DESCRIPTION="The additional tables for IBus-Table"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-table-1.2.0.20090904
	!<app-i18n/ibus-table-1.2.0.20090904
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "You should run ibus-setup and enable IM Engines you want to use!"
	elog
}