# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zpaq/zpaq-2.05.ebuild,v 1.5 2012/05/24 04:35:17 vapier Exp $

EAPI=3

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils

MY_P=${PN}.${PV/./}
DESCRIPTION="A unified compressor for PAQ algorithms"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="=app-arch/libzpaq-2*"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	EPATCH_OPTS+=-p1 epatch "${FILESDIR}"/${PN}-${PV%.*}-autotools.patch
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	autotools-utils_src_configure
}

pkg_postinst() {
	elog "You may also want to install app-arch/zpaq-extras package which provides"
	elog "few additional configs and preprocessors for use with zpaq."
}
