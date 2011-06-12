# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtpolar/qwtpolar-0.1.0.ebuild,v 1.1 2011/06/12 15:26:07 scarabeus Exp $

EAPI=4

inherit multilib qt4-r2

DESCRIPTION="Library for displaying values on a polar coordinate system"
HOMEPAGE="http://qwtpolar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="qwt"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qwt:5[svg]"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "s:/path/to/qwt-5.2/include:${EPREFIX}/usr/include/qwt5:g" \
		-e "s:/path/to/qwt-5.2/lib:${EPREFIX}/usr/$(get_libdir):g" \
		-e "/= QwtPolarDesigner/ d" \
		-e "s:/usr/local/qwtpolar-0.1.0:/usr/:g" \
		${PN}.pri || die

	sed -i \
		-e "s:{QWT_POLAR_ROOT}/lib:{QWT_POLAR_ROOT}/$(get_libdir):" \
		src/src.pro || die
}

src_install() {
	qt4-r2_src_install

	rm -rf "${ED}/usr/doc" || die
	dodir /usr/include/${PN}
	mv "${ED}/usr/include/"*.h "${ED}/usr/include/${PN}/" || die

	doman doc/man/man3/*
	dohtml -r doc/html
}
