# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-contacts/gnome-contacts-3.2.2.ebuild,v 1.3 2012/05/05 06:25:18 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GNOME contact management application"
HOMEPAGE="https://live.gnome.org/Design/Apps/Contacts"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/folks-0.6.1.1
	>=dev-libs/glib-2.29.12:2
	dev-libs/libgee:0
	>=gnome-extra/evolution-data-server-3[gnome-online-accounts]
	>=gnome-base/gnome-desktop-3.0:3
	net-libs/gnome-online-accounts
	net-libs/telepathy-glib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.0:3
	x11-libs/libnotify
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17"
# Regenerating C from vala sources requires:
#	>=dev-lang/vala-0.14.0:0.14
#	net-libs/telepathy-glib[vala]

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS" # README is empty
	# We do not need valac when building from pre-generated C sources,
	# but configure checks for it anyway
	G2CONF="${G2CONF} VALAC=$(type -P true)"
}
