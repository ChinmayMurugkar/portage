# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Weather/PEAR-Services_Weather-1.4.6.ebuild,v 1.1 2012/01/18 22:13:05 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="This class acts as an interface to various online weather-services"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="minimal"
RDEPEND="dev-lang/php[ctype]
	>=dev-php/PEAR-HTTP_Request-1.2.4-r1
	!minimal? ( >=dev-php/PEAR-Cache-1.5.4-r1
		    >=dev-php/PEAR-DB-1.7.6-r1
		    >=dev-php/PEAR-SOAP-0.8.1-r1
		    >=dev-php/PEAR-XML_Serializer-0.15.0-r1
		    >=dev-php/PEAR-Net_FTP-1.3.1 )"
