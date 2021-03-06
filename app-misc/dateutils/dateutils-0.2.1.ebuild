# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dateutils/dateutils-0.2.1.ebuild,v 1.1 2012/06/19 01:44:08 radhermit Exp $

EAPI="4"

DESCRIPTION="Command line date and time utilities"
HOMEPAGE="http://hroptatyr.github.com/dateutils/"
SRC_URI="mirror://github/hroptatyr/${PN}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}
