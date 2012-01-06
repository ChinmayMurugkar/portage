# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mediastreamer-amr/mediastreamer-amr-0.0.1.ebuild,v 1.5 2012/01/06 15:03:29 ranger Exp $

EAPI="4"

inherit multilib

MY_P="msamr-${PV}"

DESCRIPTION="mediastreamer plugin: add AMR Narrow Band support"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases-noredirect/linphone/plugins/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND=">=media-libs/mediastreamer-2.0.0
	>=media-libs/opencore-amr-0.1.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	# strict: don't want -Werror
	econf \
		--libdir=/usr/$(get_libdir) \
		--disable-strict
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README
}
