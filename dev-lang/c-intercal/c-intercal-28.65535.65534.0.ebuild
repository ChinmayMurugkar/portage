# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/c-intercal/c-intercal-28.65535.65534.0.ebuild,v 1.1 2010/09/11 09:57:37 ulm Exp $

inherit elisp-common eutils multilib versionator

# C-INTERCAL uses minor-major ordering of version components and
# negative version numbers. We map version components -1, -2, ...
# to 65535, 65534, ..., and subtract one from the next component.
# For example, upstream version 0.28 is mapped to Gentoo version 28.0
# and 0.-2.0.29 is mapped to 28.65535.65534.0.
get_intercal_version() {
	local i=.${1:-${PV}} j k c=0
	while [[ ${i} ]]; do
		(( k = ${i##*.} + c ))
		(( (c = (k >= 32768)) && (k -= 65536) ))
		i=${i%.*}
		j=${j}.${k}
	done
	echo ${j#.}
}

MY_PV=$(get_intercal_version)
DESCRIPTION="C-INTERCAL - INTERCAL to binary (via C) compiler"
HOMEPAGE="http://c.intercal.org.uk"
SRC_URI="http://overload.intercal.org.uk/c/ick-${MY_PV}.pax.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs examples"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

MY_PV2=${MY_PV%.${MY_PV##*.}}
S="${WORKDIR}/ick-${MY_PV2##*.}.${MY_PV##*.}"
SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	tar xzf "${DISTDIR}/${A}" || die "tar failed"
}

src_compile() {
	econf
	emake || die

	if use emacs; then
		elisp-compile etc/intercal.el || die
	fi
}

src_install() {
	# Thinks the directories exist, won't as this is done to a DESTDIR...
	#dodir /usr/bin
	#dodir /usr/$(get_libdir)
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS NEWS README doc/THEORY.txt

	if use emacs; then
		elisp-install ${PN} etc/intercal.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r pit || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
