# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/arx-libertatis/arx-libertatis-1.0.3.ebuild,v 1.1 2012/07/31 09:10:33 hasufell Exp $

EAPI=4

inherit eutils cmake-utils gnome2-utils games

DESCRIPTION="Cross-platform port of Arx Fatalis, a first-person role-playing game"
HOMEPAGE="http://arx-libertatis.org/"
SRC_URI="mirror://sourceforge/arx/${P}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall demo debug unity-build crash-reporter tools"

COMMON_DEPEND=">=dev-libs/boost-1.39
	media-libs/devil[jpeg]
	media-libs/freetype
	media-libs/glew
	media-libs/libsdl[opengl]
	media-libs/openal
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	crash-reporter? (
		x11-libs/qt-core:4[ssl]
		x11-libs/qt-gui:4
		)"
RDEPEND="${COMMON_DEPEND}
	crash-reporter? ( sys-devel/gdb )"
DEPEND="${COMMON_DEPEND}"
PDEPEND="cdinstall? ( >=games-rpg/arx-fatalis-data-1.21 )
	demo? ( games-rpg/arx-fatalis-demo )"

DOCS=( README.md AUTHORS CHANGELOG )

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_configure() {
	use debug && CMAKE_BUILD_TYPE=Debug

	# editor does not build
	local mycmakeargs=(
		$(cmake-utils_use unity-build UNITY_BUILD)
		$(cmake-utils_use_build tools TOOLS)
		$(cmake-utils_use_build crash-reporter CRASHREPORTER)
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DGAMESBINDIR="${GAMES_BINDIR}"
		-DCMAKE_INSTALL_DATAROOTDIR="${GAMES_DATADIR_BASE}"
		-DICONDIR=/usr/share/icons/hicolor/128x128/apps
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dogamesbin "${FILESDIR}"/arx-data-copy
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	einfo "This package only installs the game binary."
	if ! use cdinstall || ! use demo ; then
		elog "You need the demo or full game data."
		elog "See http://wiki.arx-libertatis.org/Getting_the_game_data for more information"
		elog
		elog "You might want to enable cdinstall or demo useflag."
		elog
		elog "If you have already installed the game or use the STEAM version,"
		elog "run \"${GAMES_BINDIR}/arx-data-copy /path/to/installed-arx /usr/local/share/games/arx\"."
	fi

	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
