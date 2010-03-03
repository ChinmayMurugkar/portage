# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/oasis/oasis-4.0.ebuild,v 1.3 2010/03/02 18:58:27 mr_bones_ Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

MY_P="${PN}${PV}_Linux"

DESCRIPTION="A direct-method program for SAD/SIR phasing"
HOMEPAGE="http://cryst.iphy.ac.cn/Project/protein/protein-I.html"
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/${MY_P}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="ccp4 oasis"
IUSE="examples +minimal"

RDEPEND="
	${RDEPEND}
	sci-chemistry/ccp4-apps
	sci-chemistry/pymol
	sci-libs/mmdb
	sci-visualization/gnuplot
	!minimal? (
		sci-chemistry/solve-resolve-bin
		sci-chemistry/arp-warp-bin
	)"
DEPEND="sci-libs/ccp4-libs"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	rm bin/{fnp2fp,gnuplot,oasis4-0,seq} || die
	epatch "${FILESDIR}"/${PV}-makefile.patch
}

src_compile() {
	emake \
		-C src \
		F77="$(tc-getFC)" \
		CCP4_LIB="${EPREFIX}/usr/$(get_libdir)" \
		Linux || die
}

src_install() {
	dobin src/{${PN},fnp2fp} || die

	exeinto /usr/$(get_libdir)/${PN}
	doexe bin/*.*sh || die

	insinto /usr/$(get_libdir)/${PN}/html
	doins bin/html/* || die
	chmod 755 "${ED}"/usr/$(get_libdir)/${PN}/html/*.{csh,awk} || die

	if use examples; then
		insinto /usr/share/${PN}
		doins -r examples || die
	fi

	cat >> "${T}"/25oasis <<- EOF
	oasisbin="${EPREFIX}/usr/$(get_libdir)/${PN}"
	EOF

	doenvd "${T}"/25oasis
}
