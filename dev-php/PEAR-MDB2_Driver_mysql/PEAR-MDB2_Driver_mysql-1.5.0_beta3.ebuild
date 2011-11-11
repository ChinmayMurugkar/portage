# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_mysql/PEAR-MDB2_Driver_mysql-1.5.0_beta3.ebuild,v 1.4 2011/11/10 18:40:00 jer Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Database Abstraction Layer, mysql driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta3
		dev-lang/php[mysql]"
RDEPEND="${DEPEND}"
