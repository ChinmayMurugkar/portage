# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/exfat-utils/exfat-utils-0.9.7.ebuild,v 1.1 2012/03/17 15:19:30 ssuominen Exp $

EAPI=4
inherit scons-utils toolchain-funcs

DESCRIPTION="exFAT filesystem utilities"
HOMEPAGE="http://code.google.com/p/exfat/"
SRC_URI="http://exfat.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	tc-export CC
	escons CCFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin dump/dumpexfat label/exfatlabel mkfs/mkexfatfs fsck/exfatfsck
	dosym mkexfatfs /usr/sbin/mkfs.exfat
	dosym exfatfsck /usr/sbin/fsck.exfat

	doman */*.8
	dodoc ChangeLog
}
