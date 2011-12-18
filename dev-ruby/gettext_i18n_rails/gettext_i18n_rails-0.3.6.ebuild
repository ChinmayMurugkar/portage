# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gettext_i18n_rails/gettext_i18n_rails-0.3.6.ebuild,v 1.1 2011/12/18 12:07:30 graaff Exp $

EAPI="4"

# jruby support requires sqlite3 support for jruby.
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Readme.md"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb VERSION"

inherit ruby-fakegem

DESCRIPTION="FastGettext / Rails integration."
HOMEPAGE="https://github.com/grosser/gettext_i18n_rails"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/activerecord )"
ruby_add_rdepend "dev-ruby/fast_gettext dev-ruby/ruby_parser"

all_ruby_prepare() {
	rm Gemfile Gemfile.lock || die
}
