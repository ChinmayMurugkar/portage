# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Data-Dumper/Data-Dumper-2.131.0.ebuild,v 1.6 2012/08/21 15:43:45 xmw Exp $

EAPI=4

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=2.131
inherit perl-module

DESCRIPTION="Stringified perl data structures, suitable for both printing and eval"

SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE=""

SRC_TEST="do"
