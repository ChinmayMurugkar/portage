# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foobillard/foobillard-3.0a.ebuild,v 1.17 2011/10/13 14:45:07 mr_bones_ Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="8ball, 9ball, snooker and carambol game"
HOMEPAGE="http://foobillard.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="sdl video_cards_nvidia"

DEPEND="x11-libs/libXaw
	x11-libs/libXi
	virtual/opengl
	virtual/glu
	>=media-libs/freetype-2.0.9
	media-libs/libpng
	sdl? ( media-libs/libsdl )
	!sdl? ( media-libs/freeglut )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-no_nvidia.patch \
		"${FILESDIR}"/${P}-fbsd.patch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-gl-clamp.patch

	eautoreconf
}

src_configure() {
	egamesconf \
		--enable-sound \
		$(use_enable sdl SDL) \
		$(use_enable !sdl glut) \
		$(use_enable video_cards_nvidia nvidia)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README README.FONTS
	doman foobillard.6
	newicon data/full_symbol.png foobillard.png
	make_desktop_entry foobillard Foobillard
	prepgamesdirs
}
