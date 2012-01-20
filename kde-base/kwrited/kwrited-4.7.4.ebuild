# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrited/kwrited-4.7.4.ebuild,v 1.3 2012/01/16 23:31:21 ago Exp $

EAPI=4
KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE daemon listening for wall and write messages."
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=sys-libs/libutempter-1.1.5
"
RDEPEND="${DEPEND}"
