# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-strigi-analyzer/kdegraphics-strigi-analyzer-4.6.3.ebuild,v 1.1 2011/05/07 10:47:34 scarabeus Exp $

EAPI=4

KMNAME="kdegraphics"
KMMODULE="strigi-analyzer"
inherit kde4-meta

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRACTONLY="
	libs/mobipocket/
"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
