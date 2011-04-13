# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.21.ebuild,v 1.1 2011/04/13 09:59:40 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~amd64-linux ~hppa ~ppc ~ppc64 ~x86 ~x86-interix ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-sound/musepack-tools-444"
DEPEND="${RDEPEND}"
