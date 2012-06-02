# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lifted-base/lifted-base-0.1.1.ebuild,v 1.1 2012/06/02 03:14:13 gienah Exp $

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit base haskell-cabal

DESCRIPTION="lifted IO operations from the base library"
HOMEPAGE="https://github.com/basvandijk/lifted-base"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/base-unicode-symbols-0.1.1[profile?]
		<dev-haskell/base-unicode-symbols-0.3[profile?]
		=dev-haskell/monad-control-0.3*[profile?]
		=dev-haskell/transformers-base-0.4*[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		test? ( >=dev-haskell/hunit-1.2.2
			<dev-haskell/hunit-1.3
			>=dev-haskell/test-framework-0.2.4
			<dev-haskell/test-framework-0.7
			>=dev-haskell/test-framework-hunit-0.2.4
			<dev-haskell/test-framework-hunit-0.3
			>=dev-haskell/transformers-0.2
			<dev-haskell/transformers-0.4
		)
		>=dev-haskell/cabal-1.9.2"

PATCHES=("${FILESDIR}/${PN}-0.1.1-test-ghc-6.12.patch")
