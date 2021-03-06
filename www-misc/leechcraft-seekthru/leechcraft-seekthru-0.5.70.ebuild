# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/leechcraft-seekthru/leechcraft-seekthru-0.5.70.ebuild,v 1.3 2012/07/07 10:21:47 johu Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="OpenSearch support for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}
		virtual/leechcraft-search-show
		virtual/leechcraft-downloader-http"
