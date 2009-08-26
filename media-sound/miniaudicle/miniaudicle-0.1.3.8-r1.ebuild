# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/miniaudicle/miniaudicle-0.1.3.8-r1.ebuild,v 1.1 2009/08/09 14:33:34 cedk Exp $

EAPI=2
inherit eutils toolchain-funcs flag-o-matic

MY_P=${P/a/A}

DESCRIPTION="integrated development + performance environment for chuck"
HOMEPAGE="http://audicle.cs.princeton.edu/mini/"
SRC_URI="http://audicle.cs.princeton.edu/mini/release/files/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+alsa jack oss"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	media-libs/libsndfile
	>=x11-libs/wxGTK-2.6
	app-admin/eselect-miniaudicle"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use alsa && ! use jack && ! use oss; then
		eerror "One of the following USE flags is needed: jack, alsa or oss"
		die "Please set one audio engine type"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-hid-smc.patch"
	epatch "${FILESDIR}/${P}-gcc44.patch"

	sed -i -e "s/make -C/#make -C/" \
		-e "s/g++/\$(CXX)/" \
		-e "s/-O3 -c/-c \$(CFLAGS)/" \
		makefile.* || die "sed failed"
}

compile_backend() {
	backend=$1
	einfo "Compiling against ${backend}"
	cd "${S}/chuck/src"
	emake -f "makefile.${backend}" CC=$(tc-getCC) \
		CXX=$(tc-getCXX) || die "emake failed"
	cd "${S}"
	emake -f "makefile.${backend}" CC=$(tc-getCC) \
		CXX=$(tc-getCXX) || die "emake failed"
	mv wxw/miniAudicle{,-${backend}}
	emake -f "makefile.${backend}" clean
	cd "${S}/chuck/src"
	emake -f "makefile.${backend}" clean
}

src_compile() {
	# when compiled with -march=athlon or -march=athlon-xp
	# miniaudicle crashes on removing a shred with a double free or corruption
	# it happens in Chuck_VM_Stack::shutdown() on the line
	#   SAFE_DELETE_ARRAY( stack );
	replace-cpu-flags athlon athlon-xp i686

	use jack && compile_backend jack
	use alsa && compile_backend alsa
	use oss && compile_backend oss
}

src_install() {
	use jack && dobin wxw/miniAudicle-jack
	use alsa && dobin wxw/miniAudicle-alsa
	use oss && dobin wxw/miniAudicle-oss
	dodoc BUGS README.linux VERSIONS
}

pkg_postinst() {
	elog "miniAudicle now can use many audio engines, so you can specify audio engine"
	elog "with miniAudicle-{jack,alsa,oss}"
	elog "Or you can use 'eselect miniaudicle' to set the audio engine"

	einfo "Calling eselect miniaudicle update..."
	eselect miniaudicle update --if-unset
}