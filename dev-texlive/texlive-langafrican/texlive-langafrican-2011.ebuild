# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langafrican/texlive-langafrican-2011.ebuild,v 1.4 2012/01/17 17:39:04 phajdan.jr Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="ethiop ethiop-t1 fc hyphen-ethiopic collection-langafrican
"
TEXLIVE_MODULE_DOC_CONTENTS="ethiop.doc ethiop-t1.doc fc.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ethiop.source "
inherit  texlive-module
DESCRIPTION="TeXLive African scripts"

LICENSE="GPL-2 GPL-1 GPL-2 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} "
