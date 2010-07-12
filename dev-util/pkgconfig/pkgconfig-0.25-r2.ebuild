# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.25-r2.ebuild,v 1.1 2010/07/11 12:28:28 ssuominen Exp $

EAPI=2
inherit eutils flag-o-matic

MY_P=pkg-config-${PV}

DESCRIPTION="Package config system that manages compile/link flags"
HOMEPAGE="http://pkgconfig.freedesktop.org/wiki/"
SRC_URI="http://pkgconfig.freedesktop.org/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="elibc_FreeBSD hardened"

DEPEND=">=dev-libs/popt-1.15"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# XXX: Bug in autoconf 2.66, or pkg-config?
	epatch "${FILESDIR}"/${P}-dnl.patch
}

src_configure() {
	use ppc64 && use hardened && replace-flags -O[2-3] -O1

	# Force using all the requirements when linking, so that needed -pthread
	# lines are inherited between libraries
	local myconf
	use elibc_FreeBSD && myconf="--enable-indirect-deps"

	econf \
		--docdir=/usr/share/doc/${PF}/html \
		--with-installed-popt \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
