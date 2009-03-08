# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-user/qemu-user-0.10.0.ebuild,v 1.1 2009/03/07 14:31:12 lu_zero Exp $

inherit eutils flag-o-matic

MY_PN=${PN/-user/}
MY_P=${P/-user/}

SRC_URI="http://savannah.nongnu.org/download/${MY_PN}/${MY_P}.tar.gz"

DESCRIPTION="Open source dynamic translator"
HOMEPAGE="http://bellard.org/qemu/index.html"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc64"
IUSE=""
RESTRICT="strip test binchecks"

DEPEND="app-text/texi2html
	!<=app-emulation/qemu-0.7.0"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# avoid strip
	sed -i 's/$(INSTALL) -m 755 -s/$(INSTALL) -m 755/' Makefile
}

src_compile() {
	local mycc conf_opts

	conf_opts="--enable-linux-user"
	conf_opts="${conf_opts} --disable-darwin-user --disable-bsd-user"
	conf_opts="${conf_opts} --disable-system"
	conf_opts="${conf_opts} --disable-vnc-tls"
	conf_opts="$conf_opts --disable-curses"
	conf_opts="$conf_opts --disable-gfx-check --disable-sdl"
	conf_opts="$conf_opts --disable-vde"
	conf_opts="$conf_opts --disable-kqemu"
#	use fdt || conf_opts="--disable-fdt"

	conf_opts="$conf_opts --prefix=/usr --disable-bluez --disable-kvm"

	./configure ${conf_opts} || die "econf failed"

	mycc=$(cat qemu/config-host.mak | egrep "^CC=" | cut -d "=" -f 2)

	filter-flags -fpie -fstack-protector

	# If using gentoo's compiler set the SPEC to non-hardened
	if [ ! -z ${GCC_SPECS} -a -f ${GCC_SPECS} ]; then
		local myccver=$(${mycc} -dumpversion)
		local gccver=$($(tc-getBUILD_CC) -dumpversion)

		#Is this a SPEC for the right compiler version?
		myspec="${GCC_SPECS/${gccver}/${myccver}}"
		if [ "${myspec}" == "${GCC_SPECS}" ]; then
			shopt -s extglob
			GCC_SPECS="${GCC_SPECS/%hardened*specs/vanilla.specs}"
			shopt -u extglob
		else
			unset GCC_SPECS
		fi
	fi

	emake || die "emake qemu failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -fR "${D}/usr/share"
	dohtml qemu-doc.html
	dohtml qemu-tech.html
}

