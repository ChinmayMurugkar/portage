# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-1.2.0.0.ebuild,v 1.6 2012/04/03 21:34:48 slyfox Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="http://www.math.chalmers.se/~rjmh/QuickCheck/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/random"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"
