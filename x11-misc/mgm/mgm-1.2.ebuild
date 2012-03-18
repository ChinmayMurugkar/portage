# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.2.ebuild,v 1.4 2012/03/18 15:52:58 armin76 Exp $

DESCRIPTION="Moaning Goat Meter: load and status meter written in Perl"
HOMEPAGE="http://www.linuxmafia.com/mgm"
SRC_URI="http://downloads.xiph.org/releases/mgm/${P}.tgz"

KEYWORDS="~amd64 ppc x86"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"

src_install() {
	exeinto /usr/share/mgm
	doexe mgm || die "doexe failed."
	dosym /usr/share/mgm/mgm /usr/bin/mgm
	insinto /usr/share/mgm
	doins -r lib modules || die "doins failed."
	dohtml doc/*
}
