# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-6.4.26.ebuild,v 1.1 2011/11/25 21:50:37 bicatali Exp $

EAPI=4

inherit autotools fortran-2 versionator

MV=$(get_major_version)
MY_PN=${PN}${MV}
DOC_PV=0613
EX_PV=6.4.18

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://projects.hepforge.org/pythia6/"

# pythia6 from root is needed for some files to interface pythia6 with root.
# To produce a split version, replace the 6.4.x by the current version:
# svn export http://svn.hepforge.org/pythia6/tags/v_6_4_x/ pythia-6.4.x
# tar cjf pythia-6.4.x.tar.bz2
SRC_URI="http://dev.gentoo.org/~bicatali/${P}.tar.bz2
	ftp://root.cern.ch/root/pythia6.tar.gz
	doc? ( http://home.thep.lu.se/~torbjorn/pythia/lutp${DOC_PV}man2.pdf )
	examples? ( mirror://gentoo/${PN}-${EX_PV}-examples.tar.bz2 )"

SLOT="6"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs"

DEPEND="virtual/fortran"
RDEPEND="${DEPEND}"

src_prepare() {
	cp ../pythia6/tpythia6_called_from_cc.F .
	cp ../pythia6/pythia6_common_address.c .
	cat > configure.ac <<-EOF
		AC_INIT(${PN},${PV})
		AM_INIT_AUTOMAKE
		AC_PROG_F77
		LT_INIT
		AC_CHECK_LIB(m,sqrt)
		AC_CONFIG_FILES(Makefile)
		AC_OUTPUT
	EOF
	echo >> Makefile.am "lib_LTLIBRARIES = libpythia6.la"
	echo >> Makefile.am "libpythia6_la_SOURCES = \ "
	# replace wildcard from makefile to ls in shell
	local f
	for f in py*.f struct*.f up*.f fh*.f; do
		echo  >> Makefile.am "  ${f} \\"
	done
	echo  >> Makefile.am "  ssmssm.f sugra.f visaje.f pdfset.f \\"
	echo  >> Makefile.am "  tpythia6_called_from_cc.F pythia6_common_address.c"
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	dodoc update_notes.txt
	use doc && dodoc "${DISTDIR}"/lutp${DOC_PV}man2.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r "${WORKDIR}"/examples
	fi
}
