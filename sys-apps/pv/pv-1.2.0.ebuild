# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pv/pv-1.2.0.ebuild,v 1.11 2011/12/22 14:35:56 jer Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="http://pipeviewer.googlecode.com/files/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc64-solaris ~x86-solaris"
IUSE="nls"

DOCS=( README doc/NEWS doc/TODO )

src_configure() {
	econf $(use_enable nls)
}

src_compile() {
	emake LD="$(tc-getLD)"
}
