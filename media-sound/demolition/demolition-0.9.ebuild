# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/demolition/demolition-0.9.ebuild,v 1.8 2008/10/08 09:52:21 flameeyes Exp $

IUSE=""

S="${WORKDIR}/demolition"

DESCRIPTION="Destruction/stress testing tool for LADSPA plugins"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/demolition.html"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc"

RDEPEND="=dev-libs/glib-1.2*
	 media-libs/ladspa-sdk"
DEPEND="${RDEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin demolition || die "dobin failed"
}
