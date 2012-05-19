# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subunit/subunit-0.0.8.ebuild,v 1.1 2012/05/19 17:03:34 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-pypy-*" # mis-detected sitedir
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python

DESCRIPTION="A streaming protocol for test results"
HOMEPAGE="https://launchpad.net/subunit http://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz
	http://dev.gentoo.org/~floppym/distfiles/${P}-missing.tar.gz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/testtools-0.9.15"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-libs/check
	dev-util/cppunit
	virtual/pkgconfig"

src_prepare() {
	python_clean_py-compile_files
	python_src_prepare
}

src_test() {
	testing() {
		python_convert_shebangs ${PYTHON_ABI} runtests.py || return
		emake check
	}
	python_execute_function -s testing
}

pkg_postinst() {
	python_mod_optimize subunit
}

pkg_postrm() {
	python_mod_cleanup subunit
}
