# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.13.ebuild,v 1.2 2012/08/10 22:54:27 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="AMD Geode GX and LX video driver"

KEYWORDS="~x86"
IUSE="ztv"

RDEPEND="<x11-base/xorg-server-1.12.99"
DEPEND="${RDEPEND}
	ztv? (
		sys-kernel/linux-headers
	)"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ztv)
	)
	xorg-2_pkg_setup
}
