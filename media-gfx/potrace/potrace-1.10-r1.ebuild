# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potrace/potrace-1.10-r1.ebuild,v 1.7 2011/12/09 11:36:53 naota Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Transforming bitmaps into vector graphics"
HOMEPAGE="http://potrace.sourceforge.net/"
SRC_URI="http://potrace.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="metric static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--enable-zlib
		--with-libpotrace
		$(use_enable metric a4)
		$(use_enable metric)
	)
	autotools-utils_src_configure
}
