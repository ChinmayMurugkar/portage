# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxdl_view/libxdl_view-4.2-r1.ebuild,v 1.7 2012/04/30 17:14:08 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="An X-Windows Based Toolkit"
HOMEPAGE="http://www.ccp4.ac.uk/dist/x-windows/xdl_view/doc/xdl_view_top.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="static-libs"

RDEPEND="x11-libs/libXt"
DEPEND="${RDEPEND}"

PATCHES=(
		"${FILESDIR}"/${PV}-impl-dec.patch
		"${FILESDIR}"/${PV}-as-needed.patch	)
