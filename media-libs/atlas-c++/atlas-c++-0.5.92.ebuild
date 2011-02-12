# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/atlas-c++/atlas-c++-0.5.92.ebuild,v 1.8 2011/02/12 18:06:53 armin76 Exp $

inherit eutils

MY_PN="Atlas-C++"
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Atlas protocol, used in role playing games at worldforge."
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/atlas_cpp"
SRC_URI="mirror://sourceforge/worldforge/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/libsigc++-1.2"
RDEPEND=${DEPEND}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/share/doc/${MY_P}
	dodoc AUTHORS ChangeLog NEWS README ROADMAP THANKS TODO
}
