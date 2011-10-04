# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.35.ebuild,v 1.4 2011/10/03 21:58:55 maekke Exp $

EAPI=2

inherit gst-plugins-base

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.1[encode]
	media-libs/libogg"
DEPEND="${RDEPEND}"
