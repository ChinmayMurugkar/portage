# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dbus/selinux-dbus-2.20110726-r2.ebuild,v 1.1 2012/01/14 19:59:58 swift Exp $
EAPI="4"

IUSE=""
MODS="dbus"
BASEPOL="2.20110726-r11"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dbus"

KEYWORDS="~amd64 ~x86"
