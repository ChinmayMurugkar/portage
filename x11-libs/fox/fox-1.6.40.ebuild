# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.6.40.ebuild,v 1.2 2010/09/24 19:20:19 hwoarang Exp $

EAPI="2"

inherit fox

LICENSE="LGPL-2.1"
SLOT="1.6"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="bzip2 jpeg opengl png tiff truetype zlib"

RDEPEND="x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/fox-wrapper
	bzip2? ( >=app-arch/bzip2-1.0.2 )
	jpeg? ( >=media-libs/jpeg-6b )
	opengl? ( virtual/opengl )
	png? ( >=media-libs/libpng-1.2.5 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	truetype? ( =media-libs/freetype-2*
		x11-libs/libXft )
	zlib? ( >=sys-libs/zlib-1.1.4 )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-libs/libXt"

FOXCONF="$(use_enable bzip2 bz2lib) \
	$(use_enable jpeg) \
	$(use_with opengl) \
	$(use_enable png) \
	$(use_enable tiff) \
	$(use_with truetype xft) \
	$(use_enable zlib)"
