# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO-Zlib/IO-Zlib-1.10.ebuild,v 1.10 2010/10/14 20:25:31 ranger Exp $

EAPI=2

MODULE_AUTHOR=TOMHUGHES
inherit perl-module

DESCRIPTION="IO:: style interface to Compress::Zlib"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-IO-Compress"
DEPEND="${RDEPEND}"

SRC_TEST="do"
