# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-xmlpatterns/qt-xmlpatterns-4.8.1.ebuild,v 1.9 2012/07/08 18:05:19 armin76 Exp $

EAPI=4

inherit qt4-build

DESCRIPTION="The XmlPatterns module for the Qt toolkit"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,debug=,exceptions,qpa=]
"
RDEPEND="${DEPEND}"

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/xmlpatterns
		tools/xmlpatterns
		tools/xmlpatternsvalidator"

	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
		include/QtCore
		include/QtNetwork
		include/QtXml
		include/QtXmlPatterns
		src/network
		src/xml
		src/corelib"

	QCONFIG_ADD="xmlpatterns"
	QCONFIG_DEFINE="QT_XMLPATTERNS"

	qt4-build_pkg_setup
}

src_configure() {
	myconf+=" -xmlpatterns"

	qt4-build_src_configure
}
