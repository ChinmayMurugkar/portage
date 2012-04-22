# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-sidebar/leechcraft-sidebar-0.5.65.ebuild,v 1.1 2012/04/22 13:14:41 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Sidebar for LeechCraft with the list of tabs, quicklaunch area and tray area"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
