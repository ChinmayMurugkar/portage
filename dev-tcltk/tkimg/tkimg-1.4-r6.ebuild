# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.4-r6.ebuild,v 1.1 2012/07/07 14:05:46 jlec Exp $

EAPI=4

VIRTUALX_USE=test

inherit eutils multilib prefix virtualx

MYP="${PN}${PV}"

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://tkimg.sourceforge.net/"
SRC_URI="
	http://dev.gentoo.org/~jlec/distfiles/${P}-gentoo+bundled-tiff.patch.xz
	mirror://sourceforge/${PN}/${PV}/${MYP}.tar.bz2"

IUSE="doc test"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	dev-lang/tk
	>=dev-tcltk/tcllib-1.11
	media-libs/tiff:0
	media-libs/libpng:0
	>=sys-libs/zlib-1.2.6
	virtual/jpeg"
DEPEND="${RDEPEND}
	test? (
		x11-apps/xhost
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )"

# Fails with jpeg-turbo silently, #386253
RESTRICT="test"

S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch \
		"${WORKDIR}"/${P}-gentoo+bundled-tiff.patch \
		"${FILESDIR}"/${P}-jbig.patch \
		"${FILESDIR}"/${P}-zlib-1.2.6.patch \
		"${FILESDIR}"/${P}-libtiff.patch \
		"${FILESDIR}"/${P}-libtiff4.patch

	find compat/{libjpeg,libpng,zlib,libtiff} -delete

	sed \
		-e 's:-O2 -fomit-frame-pointer::g' \
		-e 's: -pipe::g' \
		-i */configure  || die

	eprefixify */*.h
}

src_test() {
	Xemake test || die "Xmake failed"
}

src_install() {
	local l bl

	emake \
		DESTDIR="${D}" \
		INSTALL_ROOT="${D}" \
		install

	# Make library links
	for l in "${ED}"/usr/lib*/Img*/*tcl*.so; do
		bl=$(basename $l)
		dosym Img1.4/${bl} /usr/$(get_libdir)/${bl}
	done

	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins demo.tcl
		insinto /usr/share/doc/${PF}/html
		doins -r doc/*
	fi
}
