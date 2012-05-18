# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlweb/ocamlweb-1.38.ebuild,v 1.1 2012/05/18 16:56:56 aballier Exp $

EAPI=4

inherit latex-package eutils base

DESCRIPTION="O'Caml literate programming tool"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlweb/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlweb/${P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/ocaml-3.09
	virtual/latex-base
	dev-texlive/texlive-latexextra
	"

PATCHES=(
	"${FILESDIR}/${PN}-1.37-strip.patch"
	)

src_install() {
	emake UPDATETEX="" prefix="${D}/usr" MANDIR="${D}/usr/share/man" install || die
	dodoc README CHANGES
}
