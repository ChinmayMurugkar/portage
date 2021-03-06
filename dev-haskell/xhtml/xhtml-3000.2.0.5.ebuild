# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/xhtml/xhtml-3000.2.0.5.ebuild,v 1.1 2012/05/04 13:03:34 slyfox Exp $

EAPI="3"

# haddock-2.9.2 has xhtml as a dep, so disable haddock feature
CABAL_FEATURES="lib profile"
inherit haskell-cabal

DESCRIPTION="An XHTML combinator library"
HOMEPAGE="https://github.com/haskell/xhtml"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
