# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamass-milter/spamass-milter-0.3.2.ebuild,v 1.1 2011/11/29 21:52:06 eras Exp $

EAPI=4

inherit eutils

IUSE=""

DESCRIPTION="A milter for SpamAssassin"
HOMEPAGE="http://savannah.nongnu.org/projects/spamass-milt/"
SRC_URI="http://savannah.nongnu.org/download/spamass-milt/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="|| ( mail-filter/libmilter mail-mta/sendmail )
	>=mail-filter/spamassassin-3.1.0"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 /var/lib/milter milter
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-auth_users.patch
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/spamass-milter.rc4 spamass-milter
	newconfd "${FILESDIR}"/spamass-milter.conf3 spamass-milter
	dodir /var/lib/milter
	keepdir /var/lib/milter
	fowners milter:milter /var/lib/milter

	dodoc AUTHORS NEWS README ChangeLog "${FILESDIR}/README.gentoo"
}

pkg_postinst() {
	elog "Documentation is installed in /usr/share/doc/${P}"
}
