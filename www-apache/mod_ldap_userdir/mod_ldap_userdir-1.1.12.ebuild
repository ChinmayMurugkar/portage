# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ldap_userdir/mod_ldap_userdir-1.1.12.ebuild,v 1.4 2009/09/27 19:22:42 nixnut Exp $

inherit apache-module

DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
		net-nds/openldap"
RDEPEND="${DEPEND}"

need_apache2_2

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="LDAP_USERDIR"

DOCFILES="DIRECTIVES README user-ldif posixAccount-objectclass"

src_compile() {
	econf --with-apxs="${APXS}" \
		$(use_enable ssl tls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	apache-module_src_install
	fperms 600 "${APACHE_MODULES_CONFDIR}"/47_${PN}.conf
}
