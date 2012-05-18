# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolf/kolf-4.8.3.ebuild,v 1.2 2012/05/18 06:40:59 josejx Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SELINUX_MODULE="games"
inherit kde4-meta

DESCRIPTION="KDE Minigolf Game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
