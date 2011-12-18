# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_limitipconn/mod_limitipconn-0.23.ebuild,v 1.2 2011/12/18 12:07:09 ago Exp $

inherit apache-module

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted."
HOMEPAGE="http://dominia.org/djao/limitipconn2.html"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.bz2"

LICENSE="as-is"
SLOT="2"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="test"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="LIMITIPCONN INFO"

DOCFILES="ChangeLog README"

need_apache2
