# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-service-wrapper/java-service-wrapper-3.5.14-r1.ebuild,v 1.2 2012/05/13 08:47:23 sera Exp $

EAPI="4"

WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

MY_PN="wrapper"
MY_P="${MY_PN}_${PV}_src"
DESCRIPTION="A wrapper that makes it possible to install a Java Application as daemon."
HOMEPAGE="http://wrapper.tanukisoftware.org/"
SRC_URI="http://${MY_PN}.tanukisoftware.org/download/${PV}/${MY_P}.tar.gz"

LICENSE="tanuki-community"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=virtual/jre-1.4"
DEPEND="
	>=virtual/jdk-1.4
	test? (
		dev-java/ant-junit
	)"

S="${WORKDIR}/${MY_P}"

JAVA_ANT_REWRITE_CLASSPATH="true"

java_prepare() {
	#Reported upstream http://sourceforge.net/tracker2/?func=detail&aid=2299391&group_id=39428&atid=425189
	epatch "${FILESDIR}"/${P}-as-needed.patch

	epatch "${FILESDIR}"/${P}-gentoo-wrapper-defaults.patch #414027
}

src_compile() {
	tc-export CC
	BITS="32"
	use amd64 && BITS="64"
	eant -Dbits=${BITS} jar compile-c
	if use doc; then
		javadoc -d api -sourcepath src/java/ -subpackages org \
			|| die "javadoc	failed"
	fi
}

src_test() {
	ANT_TASKS="ant-junit ant-nodeps" eant -Dbits="${BITS}" test
}

src_install() {
	java-pkg_dojar lib/wrapper.jar
	java-pkg_doso lib/libwrapper.so

	dobin bin/wrapper
	dodoc README*.txt || die
	dodoc doc/revisions.txt || die

	use doc && java-pkg_dojavadoc api
	use source && java-pkg_dosrc src/java/*
}
