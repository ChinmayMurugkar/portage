# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.4.5.ebuild,v 1.8 2009/03/07 22:13:02 fauli Exp $

EAPI=2

inherit base eutils

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="avahi gnome"

RDEPEND=">=dev-cpp/glibmm-2.6
	>=dev-cpp/gtkmm-2.6
	>=dev-libs/libsigc++-2.0
	>=net-libs/obby-0.4.4
	>=dev-cpp/libxmlpp-2.6
	x11-libs/gtksourceview:1.0
	avahi? ( >=net-libs/obby-0.4.4[avahi] )
	gnome? ( gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# There's only one test and it needs X
RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-0.4.5-gcc43.patch" )

src_compile() {
	econf \
		$(use_with gnome) \
		 || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	domenu contrib/gobby.desktop
}
