# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/childprocess/childprocess-0.3.5.ebuild,v 1.2 2012/08/19 10:21:24 blueness Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A simple and reliable solution for controlling external programs running in the background."
HOMEPAGE="https://github.com/jarib/childprocess"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard dev-ruby/rspec:2 )"

ruby_add_rdepend "virtual/ruby-ffi"

all_ruby_prepare() {
	# Remove bundler support
	rm Gemfile || die
	sed -i -e "/[Bb]undler/d" Rakefile || die

	sed -i -e '/git ls-files/d' ${RUBY_FAKEGEM_GEMSPEC} || die
}
