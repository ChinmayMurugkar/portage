# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/sgt-puzzles/sgt-puzzles-8605.ebuild,v 1.1 2009/08/18 09:52:35 vapier Exp $

EAPI="2"

inherit games eutils toolchain-funcs
if [[ ${PV} == "99999999" ]] ; then
	ESVN_REPO_URI="svn://svn.tartarus.org/sgt/puzzles/trunk"
	inherit subversion
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/puzzles/puzzles-r${PV}.tar.gz"
	S=${WORKDIR}/puzzles-r${PV}
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Simon Tatham's Portable Puzzle Collection"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/puzzles/"

LICENSE="MIT"
SLOT="0"
IUSE="doc"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=app-doc/halibut-1.0 )"

src_prepare() {
	sed -i \
		-e '1iPKG_CONFIG ?= pkg-config' \
		-e '/^GTK_CONFIG/s:=.*:= $(PKG_CONFIG) gtk+-2.0:' \
		-e 's:= -O2 -Wall -Werror -ansi -pedantic -g:+= $(CPPFLAGS):' \
		-e '/LDFLAGS/s:=:=$(LDFLAGS) :' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
	if use doc ; then
		halibut --text --html --info --pdf --ps puzzles.but
	fi
}

src_install() {
	dodir "${GAMES_BINDIR}"
	emake DESTDIR="${D}" gamesdir="${GAMES_BINDIR}" install || die
	dodoc README HACKING

	local file name size
	for file in *.R ; do
		[[ ${file} == "nullgame.R" ]] && continue
		name=$(sed -n 's/^[a-z]*\.exe://p' "${file}")
		file=${file%.R}
		newicon icons/${file}-48d24.png ${PN}-${file}.png || die
		make_desktop_entry "${GAMES_BINDIR}/${file}" "${name}" "${PN}-${file}"
	done

	if use doc ; then
		dohtml *.html
		doinfo puzzles.info
		dodoc puzzles.txt puzzles.pdf puzzles.ps
	fi

	prepgamesdirs
}