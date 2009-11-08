# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone-infinity/alephone-infinity-20080622.ebuild,v 1.2 2009/11/07 17:03:40 volkmar Exp $

inherit eutils games

DESCRIPTION="Aleph One - Marathon Infinity"
HOMEPAGE="http://trilogyrelease.bungie.org/"
SRC_URI="http://trilogyrelease.bungie.org/files/MarathonInfinity.zip
	mirror://gentoo/${PN}.png"

LICENSE="bungie-marathon"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="games-fps/alephone"
DEPEND="app-arch/unzip"

S=${WORKDIR}/Marathon\ Infinity

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r * || die "doins failed"

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry "alephone.sh infinity" "Aleph One - Marathon Infinity"

	# Make sure the extra dirs exist in case the user wants to add some data
	keepdir "${GAMES_DATADIR}"/${PN}/{Scripts,"Physics Models",Textures,Themes}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play this scenario, run:"
	elog "alephone.sh infinity"
}
