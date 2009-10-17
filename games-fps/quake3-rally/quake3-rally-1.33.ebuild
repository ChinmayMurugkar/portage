# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-rally/quake3-rally-1.33.ebuild,v 1.2 2009/10/06 23:12:42 nyhm Exp $

EAPI=2

MOD_DESC="total conversion car racing mod"
MOD_NAME="Rally"
MOD_DIR="q3rally"

inherit games games-mods

HOMEPAGE="http://www.q3rally.com/"
SRC_URI="http://www.q3rally.com/downloads/q3rally_v132.rar
	http://www.q3rally.com/downloads/qvms.pk3 -> ${PN}-qvms.pk3"

LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

DEPEND="app-arch/unrar"
RDEPEND=""

src_unpack() {
	mkdir ${MOD_DIR}
	cd ${MOD_DIR}
	unpack ${A}
}

src_prepare() {
	cp -f "${DISTDIR}"/${PN}-qvms.pk3 ${MOD_DIR}/qvms.pk3 || die
}