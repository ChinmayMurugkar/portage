# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zbar/zbar-0.10-r1.ebuild,v 1.2 2012/06/26 11:49:35 ssuominen Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit autotools eutils python

DESCRIPTION="Library and tools for reading barcodes from images or video"
HOMEPAGE="http://zbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/zbar/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk imagemagick jpeg python qt4 static-libs +threads v4l X xv"

RDEPEND="gtk? ( =dev-libs/glib-2* x11-libs/gtk+:2 )
	imagemagick? ( >=media-gfx/imagemagick-6.2.6 )
	jpeg? ( virtual/jpeg )
	python? ( gtk? ( >=dev-python/pygtk-2 ) )
	qt4? ( x11-libs/qt-core:4 x11-libs/qt-gui:4 )
	X? ( x11-libs/libXext
		xv? ( x11-libs/libXv ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-v4l1-check.patch
	python_convert_shebangs 2 examples/upcrpc.py test/{barcodetest,test_pygtk}.py
	sed -i -e '/AM_INIT_AUTOMAKE/s:-Werror ::' configure.ac || die #423581
	eautoreconf
}

src_configure() {
	econf \
		$(use_with jpeg) \
		$(use_with gtk) \
		$(use_with imagemagick) \
		$(use_with python) \
		$(use_with qt4 qt) \
		$(use_enable static-libs static) \
		$(use_enable threads pthread) \
		$(use_with X x) \
		$(use_with xv xv) \
		$(use_enable v4l video)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc HACKING NEWS README TODO
	rm -r "${ED}"/usr/share/doc/${PN}
	prune_libtool_files --all
}
