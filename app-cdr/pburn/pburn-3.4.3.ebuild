# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/pburn/pburn-3.4.3.ebuild,v 1.1 2012/01/03 11:08:24 ssuominen Exp $

# wget --user puppy --password linux "http://www.meownplanet.net/zigbert/${P}.pet"

EAPI=4
inherit eutils

DESCRIPTION="A burning tool with GTK+ frontend"
HOMEPAGE="http://murga-linux.com/puppy/viewtopic.php?t=23881"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.pet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-cdr/cddetect
	app-cdr/dvd+rw-tools
	sys-apps/hotplug2stdout
	sys-apps/usleep
	virtual/cdrtools
	>=x11-misc/gtkdialog-0.8.0"
DEPEND="app-arch/pet2tgz"

src_unpack() {
	pet2tgz -i "${DISTDIR}"/${P}.pet -o "${WORKDIR}"/${P}.tar.gz
	unpack ./${P}.tar.gz
}

src_prepare() {
	cat <<-EOF > "${T}"/${PN}
	#!/bin/bash
	"/usr/share/${PN}/${PN}" "\$@"
	EOF
}

src_install() {
	dobin "${T}"/${PN}

	dodir /usr/share
	cp -dpR usr/local/${PN} "${D}"/usr/share || die

	make_desktop_entry \
		${PN} \
		"Pburn CD/DVD/Blu-ray writer" \
		/usr/share/${PN}/${PN}20.png \
		"AudioVideo;DiscBurning"

	dohtml -r usr/share/doc/${PN}
}
