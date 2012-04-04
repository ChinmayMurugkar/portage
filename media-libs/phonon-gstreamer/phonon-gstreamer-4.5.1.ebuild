# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-gstreamer/phonon-gstreamer-4.5.1.ebuild,v 1.6 2012/04/04 01:41:06 jer Exp $

EAPI=4

[[ ${PV} == *9999 ]] && git_eclass="git-2"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

MY_PN="phonon-backend-gstreamer"
MY_P=${MY_PN}-${PV}

inherit cmake-utils ${git_eclass}

DESCRIPTION="Phonon GStreamer backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-gstreamer"
[[ ${PV} == *9999 ]] || SRC_URI="mirror://kde/stable/phonon/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
if [[ ${PV} == *9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~hppa ~x86"
fi
SLOT="0"
IUSE="alsa debug +network"

RDEPEND="
	media-libs/gstreamer
	media-plugins/gst-plugins-meta[alsa?,ogg,vorbis]
	>=media-libs/phonon-4.6.0
	>=x11-libs/qt-core-4.6.0:4[glib]
	>=x11-libs/qt-gui-4.6.0:4[glib]
	>=x11-libs/qt-opengl-4.6.0:4
	virtual/opengl
	network? ( media-plugins/gst-plugins-soup )
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PV}-fix-searching-for-phonon.patch"
)

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	cmake-utils_src_configure
}
