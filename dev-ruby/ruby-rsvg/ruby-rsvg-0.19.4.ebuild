# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-0.19.4.ebuild,v 1.7 2012/05/04 18:47:54 jdhore Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="amd64 ppc x86"
IUSE="cairo"

RDEPEND="${RDEPEND}
	>=gnome-base/librsvg-2.8"
DEPEND="${DEPEND}
	>=gnome-base/librsvg-2.8
	virtual/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}
	cairo? ( dev-ruby/rcairo )"
