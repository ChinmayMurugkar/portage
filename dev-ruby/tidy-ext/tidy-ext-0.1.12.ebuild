# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tidy-ext/tidy-ext-0.1.12.ebuild,v 1.1 2012/04/22 07:11:50 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_DOCDIR="rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem eutils

DESCRIPTION="W3C HTML Tidy library implemented as a Ruby extension."
HOMEPAGE="http://github.com/carld/tidy"

LICENSE="HTML-Tidy"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_prepare() {
	mkdir lib || die
}

each_ruby_configure() {
	${RUBY} -Cext/tidy extconf.rb || die "Unable to configure extension."
}

each_ruby_compile() {
	emake -Cext/tidy || die
	cp ext/tidy/tidy$(get_modname) lib/ || die "Unable to copy extension."
}
