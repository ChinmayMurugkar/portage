# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/laughlin-backgrounds/laughlin-backgrounds-13.92.0.1.ebuild,v 1.2 2012/06/20 15:18:47 xarthisius Exp $

EAPI=3

inherit versionator rpm

SRC_PATH=development/14/source/SRPMS
FEDORA=14

MY_P="${PN}-$(get_version_component_range 1-3)"

DESCRIPTION="Fedora official background artwork"
HOMEPAGE="https://fedoraproject.org/wiki/F14_Artwork"

# No longer available at mirrors
#SRC_URI="mirror://fedora-dev/${SRC_PATH}/${PN}-$(replace_version_separator 3 -).fc${FEDORA}.src.rpm"
SRC_URI="http://dev.gentoo.org/~xarthisius/distfiles/${PN}-$(replace_version_separator 3 -).fc${FEDORA}.src.rpm"

LICENSE="CCPL-Attribution-ShareAlike-2.0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="!x11-themes/fedora-backgrounds:14"
DEPEND=""

S="${WORKDIR}/${MY_P}"

SLOT="0"

src_unpack() {
	rpm_src_unpack

	# as of 2010-06-21 rpm.eclass does not unpack the further lzma
	# file automatically.
	unpack ./${MY_P}.tar.lzma
}

src_compile() { :; }
src_test() { :; }

src_install() {
	# The install targets are serial anyway.
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
}
