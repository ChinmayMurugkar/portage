# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-2.0.1.ebuild,v 1.3 2012/05/19 09:07:30 ssuominen Exp $

EAPI=4
KDE_LINGUAS="cs de es et fi fr it nl pl ru tr zh_TW"
KDE_REQUIRED="always"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A simple tag editor for KDE"
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 mp4 +taglib vorbis"

RDEPEND="
	flac? (
		media-libs/flac[cxx]
		media-libs/libvorbis
	)
	mp3? ( media-libs/id3lib )
	mp4? ( media-libs/libmp4v2:0 )
	taglib? ( media-libs/taglib )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}"

REQUIRED_USE="flac? ( vorbis )"

PATCHES=(
	"${FILESDIR}/${PN}-2.0.1-mp4v2-1.9.1_p479.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3 ID3LIB)
		$(cmake-utils_use_with mp4 MP4V2)
		$(cmake-utils_use_with vorbis)
		$(cmake-utils_use_with taglib)
		"-DWITH_TUNEPIMP=OFF"
		"-DWITH_KDE=ON"
		)

	kde4-base_src_configure
}
