# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-19_pre20110326.ebuild,v 1.9 2012/06/17 18:37:23 armin76 Exp $

EAPI=4

inherit libtool

MY_P=pa_stable_v${PV/pre}

DESCRIPTION="A free, cross-platform, open-source, audio I/O library"
HOMEPAGE="http://www.portaudio.com/"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="alsa +cxx debug jack oss static-libs"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable debug debug-output) \
		$(use_enable cxx) \
		$(use_enable static-libs static) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with oss)
}

src_compile() {
	emake lib/libportaudio.la || die
	emake || die
}

src_install() {
	default

	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc README.txt
	dohtml index.html
}
