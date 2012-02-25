# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/sugarcrm/sugarcrm-6.4.0.ebuild,v 1.1 2012/02/25 14:29:50 maksbotan Exp $

EAPI="2"

MY_PN="SugarCE"

inherit webapp eutils

DESCRIPTION="A complete CRM and groupware system for businesses of all sizes."
HOMEPAGE="http://www.sugarforge.org/"
SRC_URI="http://www.sugarforge.org/frs/download.php/8838/${MY_PN}-${PV}.zip"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="curl imap +json +zlib +mysql +mysqli freetds ldap mssql"

DEPEND=">=dev-lang/php-5.2.10[ssl,soap,unicode,xml,session,tokenizer,ldap?,mssql?,mysql?,mysqli?,zlib?,curl?,imap?,json?]
		dev-php/PEAR-DB
		dev-php/PEAR-Cache_Lite
		dev-php/PEAR-Mail_Mime
		virtual/httpd-cgi
		freetds? ( >=dev-db/freetds-0.64
					mssql? ( >=dev-db/freetds-0.64[mssql] ) )
		app-arch/unzip"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-Full-${PV}"

src_install () {
	webapp_src_preinst

	cd "${S}"
	einfo "Installing main files"
	cp -R . "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}"/config.php
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	for foo in cache custom data modules include ; do
		webapp_serverowned -R "${MY_HTDOCSDIR}"/"${foo}"  || die

	done

	webapp_serverowned "${MY_HTDOCSDIR}"/config.php

	elog "Please make adjustment of your php.ini or .htaccess file"
	elog "Change value \"session.path = \"  according to your desire"
	elog "Files of sessions are stored in this directory"
	elog "For more info see http://developers.sugarcrm.com/documentation.php"

	webapp_postinst_txt en "${FILESDIR}/"postinstall-en.txt
	webapp_src_install
}
