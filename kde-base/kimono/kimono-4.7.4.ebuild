# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kimono/kimono-4.7.4.ebuild,v 1.5 2012/02/18 15:34:37 nixnut Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base mono

DESCRIPTION="C# bindings for KDE"
KEYWORDS="amd64 ppc x86"
IUSE="akonadi debug plasma semantic-desktop"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep qyoto 'webkit')
	$(add_kdebase_dep smokeqt)
	$(add_kdebase_dep smokekde 'akonadi?,semantic-desktop=')
	plasma? ( $(add_kdebase_dep smokeqt 'webkit') )
	semantic-desktop? ( >=dev-libs/soprano-2.6.51[clucene] )
"
RDEPEND="${DEPEND}"

# Split from kdebindings-csharp in 4.7
add_blocker kdebindings-csharp

src_prepare() {
	kde4-base_src_prepare

	sed -i "/add_subdirectory( examples )/ s:^:#:" plasma/CMakeLists.txt
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_disable plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
	)
	kde4-base_src_configure
}
