# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cook/cook-1.0.2-r1.ebuild,v 1.11 2010/01/15 03:34:40 abcd Exp $

inherit toolchain-funcs

DESCRIPTION="COOK is an embedded language which can be used as a macro preprocessor and for similar text processing."
HOMEPAGE="http://cook.sourceforge.net/"
SRC_URI="mirror://sourceforge/cook/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	use prefix || EPREFIX=

	dodoc README doc/cook.txt doc/cook.html || die "dodoc failed"

	insinto /usr/share/doc/${PF}/example
	doins test/pcb.dbdef test/pcb.dg test/pcbprol.ps test/tempsens.pcb || die "doins failed"

	newbin src/cook cookproc || die "newbin failed"

	cat > "${T}"/README.Gentoo <<EOF
NOTICE:

 ${EPREFIX}/usr/bin/cook has been renamed to ${EPREFIX}/usr/bin/cookproc in Gentoo

 -- Karl Trygve Kalleberg <karltk@gentoo.org>
EOF
	dodoc "${T}"/README.Gentoo || die "dodoc failed"
}

pkg_postinst() {
	ewarn "${EPREFIX}/usr/bin/cook has been renamed to ${EPREFIX}/usr/bin/cookproc"
}
