# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.6.0_pre2.ebuild,v 1.1 2010/10/03 22:18:40 radhermit Exp $

EAPI=3

inherit eutils

MY_P="${P/_/}"
DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client."
HOMEPAGE="http://abook.sourceforge.net/"
SRC_URI="http://abook.sourceforge.net/devel/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-vcard-import.patch
	epatch "${FILESDIR}"/${P}-vcard-fix.patch
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS ChangeLog FAQ README TODO sample.abookrc || die "dodoc failed"
}
