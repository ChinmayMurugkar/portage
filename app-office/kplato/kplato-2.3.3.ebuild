# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kplato/kplato-2.3.3.ebuild,v 1.5 2012/04/03 20:00:55 dilfridge Exp $

EAPI=3

KMNAME="koffice"
KMMODULE="${PN}"
VIRTUALX_REQUIRED=test
inherit kde4-meta

DESCRIPTION="KOffice project management application"

KEYWORDS="amd64 x86"
IUSE="python"

DEPEND="~app-office/koffice-libs-${PV}:${SLOT}[reports]"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	KoConfig.h.cmake
	libs/
	plugins/chartshape/kdchart
"
KMEXTRA="
	filters/${KMMODULE}/
	kdgantt/
"
KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
		-DBUILD_kplato=ON
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
