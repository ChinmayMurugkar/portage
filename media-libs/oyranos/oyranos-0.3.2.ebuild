# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/oyranos/oyranos-0.3.2.ebuild,v 1.4 2012/02/08 22:25:06 mr_bones_ Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="colour management system allowing to share various settings across applications and services"
HOMEPAGE="http://www.oyranos.org/"
SRC_URI="mirror://sourceforge/oyranos/Oyranos/Oyranos%200.3/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc static-libs test xinerama"

RDEPEND="app-admin/elektra
	dev-libs/libxml2
	dev-libs/yajl
	media-gfx/exiv2
	media-libs/lcms:0
	media-libs/libpng:0
	media-libs/libraw
	media-libs/libXcm
	X? ( x11-libs/fltk:1
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXxf86vm
		xinerama? ( x11-libs/libXinerama ) )"
DEPEND="${RDEPEND}
	app-doc/doxygen
	test? ( media-libs/icc-profiles-basiccolor-printing2009
		media-libs/icc-profiles-openicc )"

src_prepare() {
	einfo remove bundled elektra yajl
	rm -rf elektra* yajl || die
	#keep bundled libXNVCtrl

	epatch "${FILESDIR}"/${P}-buildsystem.patch \
		"${FILESDIR}"/${P}-test.patch

	if ! use X ; then
		sed -e '/FLTK_GUI =/s:=.*:=:' \
			-i makefile.in || die
	fi

	sed -e '/#include/s:alpha/oyranos_alpha.h:oyranos_alpha.h:' \
		-i examples/libraw/oyranos_file.cpp || die
}

src_configure() {
	tc-export CC CXX
	econf --prefix=/usr \
		--enable-verbose \
		$(use_with X x) \
		$(use_enable X libX11) \
		$(use_enable X libXext) \
		$(use_enable X libXrandr) \
		$(use_enable X libXxf86vm) \
		$(use_enable X fltk) \
		$(use_enable static-libs static) \
		$(use_enable xinerama libXinerama)
}

src_compile() {
	emake all
	use X && emake oforms
	emake docu
}

src_install() {
	emake DESTDIR="${D}" docdir=${EPREFIX}/usr/share/doc/${P} install-main

	if ! use doc ; then
		rm -rf "${ED}/usr/share/doc/${P}/html" || die
	fi
}
