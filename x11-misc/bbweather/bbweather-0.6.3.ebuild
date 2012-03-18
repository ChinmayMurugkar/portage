# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbweather/bbweather-0.6.3.ebuild,v 1.5 2012/03/18 15:21:22 armin76 Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="blackbox weather monitor"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	x11-libs/libX11"
RDEPEND="${DEPEND}
	net-misc/wget
	x11-apps/xmessage
	!<=x11-plugins/gkrellweather-2.0.7-r1"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-asneeded.patch
	sed -i -e "s/man_DATA/man1_MANS/" \
		-e "/^mandir/d" doc/Makefile.am || die
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install || die
	dodoc README AUTHORS ChangeLog NEWS TODO data/README.bbweather || die

	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv "${D}"/usr/share/bbtools/bbtoolsrc.in \
		"${D}"/usr/share/doc/${PF}/bbtoolsrc.example
}
