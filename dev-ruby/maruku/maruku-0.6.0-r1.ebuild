# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/maruku/maruku-0.6.0-r1.ebuild,v 1.1 2009/12/21 00:10:18 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="docs/changelog.md docs/div_syntax.md docs/entity_test.md
	docs/markdown_syntax.md docs/maruku.md docs/math.md docs/other_stuff.md
	docs/proposal.md"

inherit ruby-fakegem

DESCRIPTION="A Markdown-superset interpreter written in Ruby."
HOMEPAGE="http://maruku.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend dev-ruby/syntax

all_ruby_prepare() {
	sed -i \
		-e '/Gem::manage_gems/s:^:#:' \
		-e '/jamis\.rb/s:^:#:' \
		Rakefile
}

pkg_postinst() {
	elog
	elog "You need to emerge app-text/texlive and dev-tex/latex-unicode if"
	elog "you want to use --pdf with Maruku. You may also want to emerge"
	elog "dev-tex/listings to enable LaTeX syntax highlighting."
	elog
}
