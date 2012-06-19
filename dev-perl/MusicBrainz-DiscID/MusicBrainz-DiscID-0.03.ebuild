# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MusicBrainz-DiscID/MusicBrainz-DiscID-0.03.ebuild,v 1.5 2012/06/18 19:05:30 jdhore Exp $

EAPI=4

MODULE_AUTHOR=NJH
inherit perl-module

DESCRIPTION="Perl interface for the MusicBrainz libdiscid library"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="test"

RDEPEND=">=media-libs/libdiscid-0.2.2"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	virtual/pkgconfig
	test? (
		dev-perl/Test-Pod
		virtual/perl-Test-Simple
		)"

SRC_TEST="do"

src_install() {
	perl-module_src_install

	docinto examples
	dodoc examples/discid.pl
}
