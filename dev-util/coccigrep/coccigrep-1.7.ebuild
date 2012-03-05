# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/coccigrep/coccigrep-1.7.ebuild,v 1.1 2012/03/05 11:28:34 radhermit Exp $

EAPI=4
USE_PYTHON="2"

inherit distutils elisp-common

DESCRIPTION="A semantic grep for the C language"
HOMEPAGE="http://home.regit.org/software/coccigrep/"
SRC_URI="https://github.com/regit/${PN}/tarball/v${PV/_/} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc emacs vim"

RDEPEND="dev-util/coccinelle[python]
	|| ( dev-lang/python:2.7 dev-python/argparse )
	emacs? ( virtual/emacs )
	vim? ( || ( app-editors/vim app-editors/gvim ) )"
DEPEND="doc? ( dev-python/sphinx )
	emacs? ( virtual/emacs )"

SITEFILE="50${PN}-gentoo.el"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}" || die
}

src_compile() {
	distutils_src_compile
	use doc && emake -C doc html

	if use emacs ; then
		elisp-compile editors/*.el || die
	fi
}

src_install() {
	distutils_src_install
	doman ${PN}.1

	use doc && dohtml -r doc/_build/html/*

	if use emacs ; then
		elisp-install ${PN} editors/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}"/${SITEFILE} || die
	fi

	if use vim ; then
		insinto /usr/share/vim/vimfiles/plugin
		doins editors/cocci-grep.vim
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen

	einfo "Syntax highlighting is supported through dev-python/pygments."
	einfo "Install it if you want colorized output formats."
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
