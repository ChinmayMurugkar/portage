# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/herwig/herwig-6.5.20.ebuild,v 1.1 2012/01/22 21:24:44 bicatali Exp $

EAPI=4
inherit versionator autotools fortran-2

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})
MY_P=${PN}${PV1}${PV2}${PV3}
MY_PINC="$(echo ${PN}|tr '[:lower:]' '[:upper:]')${PV1}${PV2}.INC"

DESCRIPTION="High Energy Physics Event Generator"
HOMEPAGE="http://www.hep.phy.cam.ac.uk/theory/webber/Herwig/"
COM_URI="http://www.hep.phy.cam.ac.uk/theory/webber/Herwig"
SRC_URI="${COM_URI}/${MY_P}.f
	${COM_URI}/${MY_P}.inc
	${COM_URI}/${MY_PINC}
	doc? ( ${COM_URI}/hw65_manual.pdf )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="!sci-physics/cernlib-montecarlo[herwig]"
DEPEND="${RDEPEND}
	virtual/fortran"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/* "${S}"
}

src_prepare() {
	sed -i \
		-e "s/${PN}.*.inc/${MY_P}.inc/" \
		${MY_PINC} || die
	cat > configure.ac <<-EOF
		AC_INIT(${PN},${PV})
		AM_INIT_AUTOMAKE
		AC_PROG_F77
		AC_PROG_LIBTOOL
		AC_CONFIG_FILES(Makefile)
		AC_OUTPUT
	EOF
	cat > Makefile.am <<-EOF
		lib_LTLIBRARIES = lib${PN}.la
		lib${PN}_la_SOURCES = ${MY_P}.f
		pkginclude_HEADERS = \
			${MY_PINC} \
			${MY_P}.inc

	EOF
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc "${DISTDIR}"/hw65_manual.pdf
}
