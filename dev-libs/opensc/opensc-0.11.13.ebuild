# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.13.ebuild,v 1.8 2010/11/29 13:43:03 flameeyes Exp $

EAPI="2"

inherit eutils

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc openct pcsc-lite"

# libtool is required at runtime for libltdl
RDEPEND="dev-libs/openssl
	sys-libs/zlib
	sys-devel/libtool
	sys-libs/readline
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use openct; then
		elog "Support for openct is deprecated."
		elog "It is recommended to use pcsc-lite."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}+pcsc-lite-1.6.2.patch
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable doc) \
		$(use_enable openct) \
		$(use_enable pcsc-lite pcsc) \
		--with-pinentry="/usr/bin/pinentry"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
