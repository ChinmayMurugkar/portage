# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.8.ebuild,v 1.5 2010/06/07 06:18:50 pva Exp $

GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="A FM-radio tuner for the GNOME desktop"
HOMEPAGE="http://projects.gnome.org/gnomeradio/"
SRC_URI="http://launchpad.net/${PN}/stable/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="lirc"

RDEPEND=">=gnome-extra/gnome-media-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gconf-2.12
	>=gnome-base/gnome-vfs-2.12
	=media-libs/gst-plugins-base-0.10*
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	app-text/rarian"

DOCS="AUTHORS ChangeLog NEWS README* TODO"
