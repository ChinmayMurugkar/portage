# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.16.ebuild,v 1.9 2010/01/05 18:17:04 nixnut Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to output sound to esound"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gstreamer-0.10.24
	>=media-libs/gst-plugins-base-0.10.24"
