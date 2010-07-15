# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPI/PPI-1.213.ebuild,v 1.1 2010/07/15 11:52:56 tove Exp $

EAPI=3

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Parse, Analyze and Manipulate Perl (without perl)"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.20
	>=dev-perl/Params-Util-1.00
	>=dev-perl/Clone-0.30
	>=virtual/perl-Digest-MD5-2.35
	dev-perl/IO-String
	>=dev-perl/List-MoreUtils-0.16
	>=virtual/perl-Storable-2.17"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/File-Remove-1.42
		>=virtual/perl-Test-Simple-0.86
		>=dev-perl/Test-NoWarnings-0.084
		>=virtual/perl-File-Spec-0.84
		dev-perl/Test-SubCalls
		dev-perl/Test-Object
		>=dev-perl/Class-Inspector-1.22 )"
#		>=dev-perl/Test-ClassAPI-1.04 )"

SRC_TEST="do"
