# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screengrab/screengrab-0.6.1.ebuild,v 1.1 2010/03/02 16:19:42 hwoarang Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Qt tool for geting screenshots"
HOMEPAGE="http://code.google.com/p/screengrab-qt/"
SRC_URI="http://screengrab-qt.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
"
RDEPEND="${DEPEND}"
