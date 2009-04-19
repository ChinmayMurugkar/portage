# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-glib/poppler-glib-0.10.5.ebuild,v 1.7 2009/04/18 13:01:44 ranger Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-glib.so"
HOMEPAGE="http://poppler.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="+cairo"

PROPERTIES="virtual"

RDEPEND="|| ( ~dev-libs/poppler-glib-${PV}[cairo?] ~app-text/poppler-bindings-${PV}[gtk,cairo?] )"
DEPEND="${RDEPEND}"
