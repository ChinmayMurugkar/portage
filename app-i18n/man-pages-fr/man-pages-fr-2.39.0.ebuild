# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-fr/man-pages-fr-2.39.0.ebuild,v 1.4 2011/08/26 20:45:34 grobian Exp $

DESCRIPTION="A somewhat comprehensive collection of french Linux man pages"
HOMEPAGE="http://fr.tldp.org/manfr.php"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/translations/${P}.tar.bz2"

LICENSE="as-is GPL-2 BSD MIT LDP-1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-linux"
IUSE=""

RDEPEND="virtual/man"

src_compile() { :; }

src_install() {
	dodoc LISEZ_MOI changements
	for x in man? ; do
		insinto /usr/share/man/fr/${x}
		doins ${x}/* || die "doins ${x}"
	done
}
