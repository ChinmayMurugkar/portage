# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksnapshot/ksnapshot-4.7.4.ebuild,v 1.4 2012/02/18 15:57:33 nixnut Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Screenshot Utility"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug kipi"

DEPEND="
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.7-kipi.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	kde4-base_src_configure
}
