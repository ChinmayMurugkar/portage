# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.24.ebuild,v 1.10 2010/01/05 18:12:43 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
