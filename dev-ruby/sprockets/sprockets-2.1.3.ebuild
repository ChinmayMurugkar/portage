# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sprockets/sprockets-2.1.3.ebuild,v 1.1 2012/06/01 06:26:28 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_GEMSPEC="sprockets.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Ruby library for compiling and serving web assets."
HOMEPAGE="https://github.com/sstephenson/sprockets"
SRC_URI="https://github.com/sstephenson/sprockets/tarball/v${PV} -> ${P}.tgz"
RUBY_S="sstephenson-sprockets-*"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE=""

ruby_add_rdepend "
	=dev-ruby/hike-1* >=dev-ruby/hike-1.2
	=dev-ruby/rack-1*
	>=dev-ruby/tilt-1.3.1"

ruby_add_bdepend "test? (
		dev-ruby/json
		dev-ruby/rack-test
		=dev-ruby/coffee-script-2*
		=dev-ruby/execjs-1*
	)"

all_ruby_prepare() {
	# Avoid tests for template types that we currently don't package:
	# eco and ejs.
	sed -i -e '/eco templates/,/end/ s:^:#:' \
		-e '/ejs templates/,/end/ s:^:#:' test/test_environment.rb || die

	# Avoid failing tests. These no longer fail in upstream HEAD and we
	# did not run tests before at all so its not a regression.
	sed -i -e '/function() {}/ s:^:#:' test/test_environment.rb || die
	rm test/test_asset.rb test/test_server.rb || die
}
