# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lxml/lxml-2.2.4.ebuild,v 1.9 2010/02/07 19:57:34 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils flag-o-matic

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/ http://pypi.python.org/pypi/lxml"
SRC_URI="http://codespeak.net/lxml/${P}.tgz"

LICENSE="BSD ElementTree GPL-2 PSF-2.4"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ~ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc examples +threads"

RDEPEND=">=dev-libs/libxml2-2.7.2
		>=dev-libs/libxslt-1.1.15
		>=dev-python/beautifulsoup-3.0.8"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc5"
# lxml tarball contains files pregenerated by Cython.

pkg_setup() {
	# Tests fail with some optimizations.
	replace-flags -O[2-9s]* -O1
}

src_prepare() {
	distutils_src_prepare

	# Disable broken tests.
	sed -e "/elementsoup\.txt/d" -i src/lxml/html/tests/test_elementsoup.py || die "sed failed"

	epatch "${FILESDIR}/${P}-python-2.7.patch"
	epatch "${FILESDIR}/${P}-python-3.patch"
}

src_compile() {
	local myconf
	use threads || myconf+=" --without-threading"
	distutils_src_compile ${myconf}
}

src_test() {
	testing() {
		# Tests are broken with Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		local module
		for module in lxml/etree lxml/objectify; do
			ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}.so" "src/${module}.so" || die "ln -fs src/${module} failed"
		done

		local return_status="0" test
		for test in test.py selftest.py selftest2.py; do
			einfo "Running ${test}"
			if ! PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" "${test}"; then
				eerror "${test} failed with Python ${PYTHON_ABI}"
				return_status="1"
			fi
		done

		return "${return_status}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/*
		dodoc *.txt
		docinto doc
		dodoc doc/*.txt
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/*
	fi
}
