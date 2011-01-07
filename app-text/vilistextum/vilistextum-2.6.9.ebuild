# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.9.ebuild,v 1.5 2011/01/07 18:05:11 jlec Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Html to ascii converter specifically programmed to get the best out of incorrect html"
HOMEPAGE="http://bhaak.dyndns.org/vilistextum/"
SRC_URI="http://bhaak.dyndns.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris"
#IUSE="unicode kde"
IUSE="unicode"

DEPEND="virtual/libiconv"
RDEPEND=""
# KDE support will be available once a version of kaptain in stable
#	 kde? ( kde-misc/kaptain )"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gentoo.diff" \
		"${FILESDIR}/${P}-prefix.patch"
	eautoreconf
}

src_configure() {
	# need hardwired locale simply because locale -a | grep -i utf-8 | head -n1
	# isn't always returning the most sensical (and working) locale
	econf \
		$(use_enable unicode multibyte) \
		$(use_with unicode unicode-locale en_US.UTF-8)
}

src_test() {
	if $(locale -a | grep -iq en_US.utf8); then
	emake -j1 \
		check || die
	else
		ewarn "If you like to run the test,"
		ewarn "please make sure en_US.UTF-8 is installed."
		die "en_US.UTF-8 locale is missing"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README CHANGES || die
	dohtml doc/*.html || die
}
