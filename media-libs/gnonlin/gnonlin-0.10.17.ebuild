# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gnonlin/gnonlin-0.10.17.ebuild,v 1.2 2012/05/05 08:02:25 jdhore Exp $

DESCRIPTION="Gnonlin is a set of GStreamer elements to ease the creation of non-linear multimedia editors."
HOMEPAGE="http://gnonlin.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=media-libs/gstreamer-0.10.30
	 >=media-libs/gst-plugins-base-0.10.30"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( || (
		>=dev-util/gtk-doc-am-1.13
		>=dev-util/gtk-doc-1.3 ) )
	test? ( dev-libs/check
		media-libs/gst-plugins-good )" # videomixer

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable doc docbook)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README RELEASE

	# For some reason, make install doesn't do this
	if use doc; then
		local htmldir="/usr/share/gtk-doc/html"
		cd "${S}/docs/libs/html"
		gtkdoc-rebase --html-dir=${htmldir} || die "gtkdoc-rebase failed"
		insinto "${htmldir}/gnonlin"
		doins "${S}"/docs/libs/html/* || die "doins docs failed"
	fi
}
