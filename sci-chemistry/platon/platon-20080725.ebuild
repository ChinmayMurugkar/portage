# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/platon/platon-20080725.ebuild,v 1.2 2008/10/07 17:01:37 markusle Exp $

inherit fortran toolchain-funcs flag-o-matic

FORTRAN="g77 gfortran"
DESCRIPTION="Versatile, SHELX-97 compatible, multipurpose crystallographic tool"
HOMEPAGE="http://www.cryst.chem.uu.nl/platon/"
SRC_URI="${P}.tar.gz"
RESTRICT="fetch"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""
# Can't do libf2c dependent on whether <gcc-4 is selected for the build,
# so we must always require it
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

pkg_nofetch() {
	einfo "Download ${A/-${PV}} from ftp://xraysoft.chem.uu.nl/pub/unix/,"
	einfo "rename it to ${A} and place it"
	einfo "in ${DISTDIR}."
	einfo "If there is a digest mismatch, please file a bug"
	einfo "at https://bugs.gentoo.org/ -- a version bump"
	einfo "is probably required."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip platon.f.Z xdrvr.c.gz
}

src_compile() {
	# easy to ICE, at least on gcc 4.3
	strip-flags

	COMMAND="$(tc-getCC) -c ${CFLAGS} xdrvr.c"
	echo ${COMMAND}
	${COMMAND} || die "Compilation of xdrvr.c failed"
	COMMAND="${FORTRANC} -c ${FFLAGS:- -O2} -fno-second-underscore platon.f"
	echo ${COMMAND}
	${COMMAND} || die "Compilation of platon.f failed"
	COMMAND="${FORTRANC} -o platon ${LDFLAGS} platon.o xdrvr.o -lX11 ${F2C}"
	echo ${COMMAND}
	${COMMAND} || die "Linking failed"
}

src_install() {
	dobin platon

	dosym platon /usr/bin/pluton
	dosym platon /usr/bin/s
	dosym platon /usr/bin/cifchk
	dosym platon /usr/bin/helena
	dosym platon /usr/bin/stidy

	insinto /usr/lib/platon
	doins check.def

	echo "CHECKDEF=\"/usr/lib/platon/check.def\"" > "${T}"/env.d
	newenvd "${T}"/env.d 50platon

	dodoc README.* VALIDATION.DOC
}
