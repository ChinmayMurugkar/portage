# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kbluetooth/kbluetooth-0.4_rc1.ebuild,v 1.1 2009/10/15 16:06:40 ssuominen Exp $

EAPI=2
KDE_LINGUAS="da de en_GB es et fr gl km lt nds pt pt_BR ro ru sv tr uk zh_CN zh_TW"
inherit kde4-base versionator

MY_PV=$(get_version_component_range 3)
MY_P=${PN}-${MY_PV/rc/RC}

DESCRIPTION="Bluetooth utils for KDE4"
HOMEPAGE="http://techbase.kde.org/Kbluetooth"
SRC_URI="http://kde-apps.org/CONTENT/content-files/112110-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +semantic-desktop"

COMMON_DEPEND=">=kde-base/solid-${KDE_MINIMAL}[bluetooth]
	>=kde-base/libkworkspace-${KDE_MINIMAL}
	>=kde-base/libknotificationitem-${KDE_MINIMAL}
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	semantic-desktop? ( >=kde-base/nepomuk-${KDE_MINIMAL} )"
RDEPEND="${COMMON_DEPEND}
	app-mobilephone/obex-data-server
	app-mobilephone/obexftp"
DEPEND="${COMMON_DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)"
	kde4-base_src_configure
}