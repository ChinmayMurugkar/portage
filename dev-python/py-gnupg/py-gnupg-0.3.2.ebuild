# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-gnupg/py-gnupg-0.3.2.ebuild,v 1.12 2009/10/11 09:34:27 grobian Exp $

inherit distutils

MY_P="GnuPGInterface-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Python module to interface with GnuPG."
HOMEPAGE="http://py-gnupg.sourceforge.net/"
SRC_URI="mirror://sourceforge/py-gnupg/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND="virtual/python
	>=app-crypt/gnupg-1.2.1-r1"

DOCS="NEWS PKG-INFO THANKS"
