# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Try-Tiny/Try-Tiny-0.110.0.ebuild,v 1.2 2011/09/24 13:25:31 grobian Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
