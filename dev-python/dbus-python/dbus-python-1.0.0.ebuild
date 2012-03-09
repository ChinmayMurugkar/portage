# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-1.0.0.ebuild,v 1.10 2012/03/09 14:48:12 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 *-jython 2.7-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit eutils python

DESCRIPTION="Python bindings for the D-Bus messagebus"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DBusBindings http://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="http://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=sys-apps/dbus-1.4.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( =dev-python/epydoc-3* )
	test? (
		dev-python/pygobject:2
		dev-python/pygobject:3
		)"

src_prepare() {
	# Fix tests with Python 3.1.
	sed -e 's/if sys.version_info\[:2\] >= (2, 7):/if sys.version_info[:2] == (2, 7) or sys.version_info[:2] >= (3, 2):/' -i test/test-standalone.py || die "sed failed"

	epatch "${FILESDIR}/${P}-test-socket-tmpdir.patch"

	python_clean_py-compile_files
	python_src_prepare
}

src_configure() {
	configuration() {
		econf \
			--docdir="${EPREFIX}"/usr/share/doc/${PF} \
			--disable-html-docs \
			$(use_enable doc api-docs)
	}
	python_execute_function -s configuration
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	python_src_test
}

src_install() {
	python_src_install

	if use doc; then
		install_documentation() {
			nonfatal dohtml -r api/*
		}
		python_execute_function -f -q -s install_documentation
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	python_clean_installation_image
}

pkg_postinst() {
	python_mod_optimize dbus
}

pkg_postrm() {
	python_mod_cleanup dbus
}
