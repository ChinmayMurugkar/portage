# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-goocanvas/ruby-goocanvas-1.1.3.ebuild,v 1.3 2012/08/17 13:08:04 johu Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby binding of GooCanvas"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${RDEPEND}
	x11-libs/goocanvas:0"
DEPEND="${DEPEND}
	x11-libs/goocanvas:0"

ruby_add_bdepend "dev-ruby/pkg-config
	dev-ruby/rcairo"
