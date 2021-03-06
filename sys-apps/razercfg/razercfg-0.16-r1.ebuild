# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/razercfg/razercfg-0.16-r1.ebuild,v 1.4 2012/07/26 16:17:35 johu Exp $

EAPI=4

inherit cmake-utils multilib eutils

DESCRIPTION="Utility for advanced configuration of Razer mice (DeathAdder, Krait, Lachesis)"

HOMEPAGE="http://bues.ch/cms/hacking/razercfg.html"
SRC_URI="http://bues.ch/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND="${DEPEND}
	qt4? ( x11-libs/qt-core:4 )
	dev-lang/python"

DEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/ldconfig/{N;d}' \
		-e '/udevadm control/{N;d}' \
		-e '/^install.*01-razer-udev.rules/{N;d}' \
		librazer/CMakeLists.txt \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-pidlogfix.patch
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}"/razerd.init.d razerd
	dodoc README razer.conf

	insinto /$(get_libdir)/udev/rules.d/
	newins "${CMAKE_BUILD_DIR}"/01-razer-udev.rules 40-razercfg.rules

	if ! use qt4; then
		rm "${D}"/usr/bin/qrazercfg
	else
		make_desktop_entry qrazercfg "Razer Mouse Settings" mouse "Qt;Settings"
	fi
}

pkg_postinst() {
	udevadm control --reload-rules && udevadm trigger --subsystem-match=usb
}
