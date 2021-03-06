# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-audiorecorder/vdr-audiorecorder-0.1.0_pre14-r2.ebuild,v 1.1 2012/07/01 11:33:15 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2 flag-o-matic

MY_P=${P/_pre/-pre}

DESCRIPTION="VDR plugin: automatically record radio-channels and split it into tracks according to RadioText-Info"
HOMEPAGE="http://www.a-land.de/audiorecorder/"
SRC_URI="http://www.zulu-entertainment.de/files/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/${MY_P#vdr-}

DEPEND=">=media-video/vdr-1.6.0
		media-libs/taglib
		virtual/ffmpeg[encode,mp3]
		>=dev-libs/tinyxml-2.6.1[stl]"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-shared-tinyxml.diff"

	vdr-plugin-2_src_prepare

	sed -i "s:include <avcodec.h>:include <libavcodec/avcodec.h>:" convert.h audiorecorder.c
	sed -i "s:RegisterI18n:// RegisterI18n:" audiorecorder.c

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS

	epatch "${FILESDIR}/${P}_ffmpeg.diff"
	epatch "${FILESDIR}/${P}_obsolete-i18n.diff"
}

src_install() {
	vdr-plugin-2_src_install
	keepdir /var/vdr/audiorecorder
	chown -R vdr:vdr "${D}"/var/vdr

	insinto /etc/vdr/plugins/audiorecorder
	doins "${S}"/contrib/audiorecorder.conf
}
