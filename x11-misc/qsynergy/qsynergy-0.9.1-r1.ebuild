# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qsynergy/qsynergy-0.9.1-r1.ebuild,v 1.2 2012/01/11 23:33:11 cardoe Exp $

EAPI=3

inherit qt4-r2

DESCRIPTION="A comprehensive and easy to use graphical front end for Synergy."
HOMEPAGE="http://www.volker-lanz.de/en/software/qsynergy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	x11-misc/synergy"

src_install () {
	qt4-r2_src_install

	dodoc README || die "README installation failed"
}
