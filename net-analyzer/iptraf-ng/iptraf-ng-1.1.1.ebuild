# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf-ng/iptraf-ng-1.1.1.ebuild,v 1.5 2012/03/16 19:07:26 ranger Exp $

EAPI=4

DESCRIPTION="A console-based network monitoring utility"
HOMEPAGE="http://fedorahosted.org/iptraf-ng/"
SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.7-r7"
DEPEND="${RDEPEND}
	!net-analyzer/iptraf"

DOCS="CHANGES FAQ README RELEASE-NOTES"

src_install() {
	default
	dohtml -r Documentation
	keepdir /var/{lib,log,lock}/iptraf-ng #376157
}
