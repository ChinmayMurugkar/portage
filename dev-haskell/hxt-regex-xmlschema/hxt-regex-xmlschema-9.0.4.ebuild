# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hxt-regex-xmlschema/hxt-regex-xmlschema-9.0.4.ebuild,v 1.1 2012/06/02 08:47:48 gienah Exp $

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A regular expression library for W3C XML Schema regular expressions"
HOMEPAGE="http://www.haskell.org/haskellwiki/Regular_expressions_for_XML_Schema"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/hxt-charproperties-9*[profile?]
		>=dev-haskell/parsec-2.1[profile?]
		<dev-haskell/parsec-4[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
