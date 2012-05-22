# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jemalloc/jemalloc-2.2.5.ebuild,v 1.6 2012/05/21 18:59:31 xarthisius Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://www.canonware.com/jemalloc/"
SRC_URI="http://www.canonware.com/download/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

IUSE="debug stats"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-strip-optimization.patch" \
		"${FILESDIR}/${PN}-2.2.1-no-pprof.patch"

	eautoreconf
}

src_configure() {
	econf \
		--with-jemalloc-prefix=j \
		$(use_enable debug) \
		$(use_enable stats)
}
