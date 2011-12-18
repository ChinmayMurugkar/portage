# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liblockfile/liblockfile-1.09.ebuild,v 1.1 2011/12/18 14:35:28 eras Exp $

EAPI=4

inherit eutils multilib autotools

DESCRIPTION="Implements functions designed to lock the standard mailboxes"
HOMEPAGE="http://www.debian.org/"
SRC_URI="mirror://debian/pool/main/libl/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

pkg_setup() {
	enewgroup mail 12
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.06-respectflags.patch
	epatch "${FILESDIR}"/${PN}-orphan-file.patch
	eautoreconf
}

src_configure() {
	econf --with-mailgroup=mail --enable-shared
}

src_install() {
	dodir /usr/{bin,include,$(get_libdir)} /usr/share/man/{man1,man3}
	emake ROOT="${ED}" install
	dodoc README Changelog
}
