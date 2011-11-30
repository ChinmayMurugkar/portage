# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jadetex/jadetex-3.13-r3.ebuild,v 1.8 2011/11/30 03:30:15 jer Exp $

inherit latex-package texlive-common

DESCRIPTION="TeX macros used by Jade TeX output"
HOMEPAGE="http://jadetex.sourceforge.net/"
SRC_URI="mirror://sourceforge/jadetex/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
RESTRICT="test"

DEPEND=">=app-text/openjade-1.3.1
	dev-texlive/texlive-fontsrecommended
	dev-texlive/texlive-genericrecommended"

src_compile() {
	VARTEXFONTS="${T}/fonts" emake || die "emake failed"
	VARTEXFONTS="${T}/fonts" TEXMFHOME="${S}" env -u TEXINPUTS \
		fmtutil --cnffile "${FILESDIR}/format.jadetex.cnf" --fmtdir "${S}/texmf-var/web2c" --all\
				|| die "failed to build format"
}

src_install() {
	# Runtime files
	insinto /usr/share/texmf/tex/jadetex
	doins dsssl.def jadetex.ltx jadetex.cfg jadetex.ini *.sty || die

	insinto /var/lib/texmf
	doins -r texmf-var/* || die

	etexlinks "${FILESDIR}/format.jadetex.cnf"

	# Doc/manpages
	dodoc ChangeLog*
	doman *.1
	dohtml -r .

	# Support for our latex setup
	insinto /etc/texmf/texmf.d
	doins "${FILESDIR}/80jadetex.cnf"
	insinto /etc/texmf/fmtutil.d
	doins "${FILESDIR}/format.jadetex.cnf"
}

pkg_postinst() {
	etexmf-update
	elog
	elog "If jadetex fails with \"TeX capacity exceeded, sorry [save size=5000]\","
	elog "increase save_size in /etc/texmf/texmf.d/80jadetex.cnf and."
	elog "remerge jadetex. See bug #21501."
	elog
}

pkg_postrm() {
	etexmf-update
}
