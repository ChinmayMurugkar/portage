# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bones/bones-3.8.0.ebuild,v 1.1 2012/08/14 14:32:45 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGME_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="default version.txt"

inherit ruby-fakegem

DESCRIPTION="Tool that creates new Ruby projects from a code skeleton"
HOMEPAGE="http://github.com/TwP/bones"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/loquacious-1.7.0
	>=dev-ruby/little-plugger-1.1.2-r1
	>=dev-ruby/rake-0.8.7"

each_ruby_test() {
	if [[ ${RUBY} == *jruby ]]; then
		ewarn "JRuby up to 1.6.7.2 is known to crash even after passing the tests."
		return 0
	fi
	each_fakegem_test
}
