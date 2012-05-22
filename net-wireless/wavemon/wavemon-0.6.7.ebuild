# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.6.7.ebuild,v 1.7 2012/05/21 19:21:03 xarthisius Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Ncurses based monitor for IEEE 802.11 wireless LAN cards"
HOMEPAGE="http://eden-feed.erg.abdn.ac.uk/wavemon/"
SRC_URI="http://eden-feed.erg.abdn.ac.uk/wavemon/stable-releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ppc sparc x86"

IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-as-needed.diff"
	epatch "${FILESDIR}/${P}-dont-override-CFLAGS.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog README
}
