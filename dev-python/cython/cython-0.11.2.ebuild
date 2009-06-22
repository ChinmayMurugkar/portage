# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cython/cython-0.11.2.ebuild,v 1.1 2009/06/07 22:29:10 arfrever Exp $

NEED_PYTHON="2.2"

inherit distutils

MY_PN="Cython"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A language for writing Python extension modules based on pyrex"
HOMEPAGE="http://www.cython.org/"
SRC_URI="http://www.cython.org/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"
DOCS="ToDo.txt USAGE.txt"

src_install() {
	distutils_src_install

	# -A c switch is for Doc/primes.c
	use doc && dohtml -A c -r Doc/*

	if use examples; then
		# Demos/ has files with .so,~ suffixes.
		# So we have to specify precisely what to install.
		insinto /usr/share/doc/${PF}/examples
		doins Demos/Makefile* Demos/setup.py Demos/*.{py,pyx}
	fi
}