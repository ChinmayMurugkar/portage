# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtick/gtick-0.4.2.ebuild,v 1.5 2010/07/24 10:03:04 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick"
SRC_URI="http://www.antcom.de/gtick/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~x86-fbsd"
IUSE="nls sndfile"

RDEPEND="x11-libs/gtk+:2
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

RESTRICT="test"

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with sndfile)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	newicon src/icon48x48.xpm ${PN}.xpm
	make_desktop_entry ${PN} "GTick"
}
