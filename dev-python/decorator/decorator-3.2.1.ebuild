# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decorator/decorator-3.2.1.ebuild,v 1.4 2011/01/07 19:35:37 ranger Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="2.4 2.5"

inherit distutils

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="http://pypi.python.org/pypi/decorator"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="README.txt"
PYTHON_MODNAME="decorator.py"

src_test() {
	testing() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" documentation3.py
		else
			PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" documentation.py
		fi
	}
	python_execute_function testing
}
