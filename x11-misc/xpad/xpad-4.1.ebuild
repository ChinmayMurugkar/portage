# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-4.1.ebuild,v 1.1 2011/12/29 18:07:05 jer Exp $

EAPI=4

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://mterry.name/xpad"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-2.12:2
	dev-libs/glib:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/pango
"
DEPEND="
	${RDEPEND}
	>=dev-util/intltool-0.31
	dev-util/pkgconfig
	sys-devel/gettext
"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )
