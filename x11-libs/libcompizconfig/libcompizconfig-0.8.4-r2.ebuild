# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libcompizconfig/libcompizconfig-0.8.4-r2.ebuild,v 1.3 2012/05/05 03:52:25 jdhore Exp $

EAPI="2"

DESCRIPTION="Compiz Configuration System"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libxml2:2
	dev-libs/protobuf
	>=x11-wm/compiz-${PV}
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.41
	virtual/pkgconfig
"

RESTRICT="test"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete || die
}
