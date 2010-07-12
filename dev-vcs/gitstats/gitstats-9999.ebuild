# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitstats/gitstats-9999.ebuild,v 1.1 2010/07/11 15:37:27 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"

inherit python git

DESCRIPTION="Statistics generator for git"
HOMEPAGE="http://gitstats.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="git://repo.or.cz/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sci-visualization/gnuplot[gd]
	dev-vcs/git"
DEPEND=""

src_prepare() {
	sed "s:basedir = os.path.dirname(os.path.abspath(__file__)):basedir = '/usr/share/gitstats':g" \
	-i gitstats || die "failed to fix static files path"
}

src_compile() {
	:;
}

src_install() {
	emake PREFIX="${D}"/usr VERSION="${PV}" install || die
	dodoc doc/{README,*.txt} || die "doc install failed"
}
