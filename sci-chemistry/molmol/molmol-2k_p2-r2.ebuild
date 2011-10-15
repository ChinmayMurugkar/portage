# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molmol/molmol-2k_p2-r2.ebuild,v 1.9 2011/10/15 09:11:00 xarthisius Exp $

EAPI=4

inherit eutils multilib prefix toolchain-funcs

MY_PV="${PV/_p/.}.0"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Publication-quality molecular visualization package"
HOMEPAGE="http://hugin.ethz.ch/wuthrich/software/molmol/index.html"
SRC_URI="
	ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-src.tar.gz
	ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-doc.tar.gz"

LICENSE="molmol"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	media-libs/mesa[motif]
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libXpm
	>=x11-libs/openmotif-2.3:0
	x11-apps/xdpyinfo"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

MMDIR="/usr/$(get_libdir)/molmol"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	rm -rf tiff*
	# Patch from http://pjf.net/science/molmol.html, where src.rpm is provided
	epatch "${FILESDIR}"/pjf_RH9_molmol2k2.diff

	epatch "${FILESDIR}"/prefix.patch
	eprefixify molmol

	epatch "${FILESDIR}"/ldflags.patch

	ln -s makedef.lnx "${S}"/makedef

	sed \
		-e "s:/bin/ksh:${EPREFIX}/bin/sh:" \
		-e "s:^MOLMOLHOME.*:MOLMOLHOME=${EPREFIX}/${MMDIR}:" \
		-i "${S}"/molmol || die
	sed \
		-e "s:^MCFLAGS.*:MCFLAGS = ${CFLAGS}:" \
		-e "s:^CC.*:CC = $(tc-getCC):" \
		-i "${S}"/makedef || die

	epatch "${FILESDIR}"/cast.patch
	epatch "${FILESDIR}"/libpng15.patch
}

src_install() {
	dobin molmol

	exeinto ${MMDIR}
	newexe src/main/molmol molmol.lnx
	insinto ${MMDIR}
	doins -r auxil help macros man setup tips

	dodoc HISTORY README
}
