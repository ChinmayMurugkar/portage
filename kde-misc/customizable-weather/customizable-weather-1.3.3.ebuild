# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/customizable-weather/customizable-weather-1.3.3.ebuild,v 1.1 2011/02/01 06:33:56 tampakrap Exp $

EAPI=3

KDE_LINGUAS="br de es fr hu it nb nl pl ro ru sr sr@latin tr zh_CN"
inherit kde4-base

MY_P="cwp-${PV}"

DESCRIPTION="KDE4 weather plasmoid. It aims to be highly customizable, but is a little harder to setup."
HOMEPAGE="http://www.kde-look.org/content/show.php/Customizable+Weather+Plasmoid?content=98925"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/98925-${MY_P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	x11-libs/qt-gui:4[accessibility]
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"
