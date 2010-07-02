# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-compat/regex-compat-0.91.ebuild,v 1.5 2010/07/01 19:58:44 jer Exp $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="One module layer over regex-posix to replace Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/cabal-1.2
		>=dev-haskell/regex-base-0.93
		>=dev-haskell/regex-posix-0.93"
