# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glassfish-deployment-api/glassfish-deployment-api-1.2.ebuild,v 1.4 2010/10/14 20:25:40 ranger Exp $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_PV=${PV/./_}

DESCRIPTION="J2EE Application Deployment Specification"
HOMEPAGE="https://glassfish.dev.java.net/"
LICENSE="sun-bcla-j2ee-deployment"
SLOT="1.2"

KEYWORDS="amd64 ppc x86"

GLASSFISH_MAJOR="v2ur2"
GLASSFISH_MINOR="b04"
SRC_URI="http://download.java.net/javaee5/${GLASSFISH_MAJOR}/promoted/source/glassfish-${GLASSFISH_MAJOR}-${GLASSFISH_MINOR}-src.zip"

IUSE=""
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/glassfish/deployment-api/"
EANT_BUILD_TARGET="all"

src_prepare() {
	default

	cd "${S}"
	epatch "${FILESDIR}/${P}-build.xml.patch"
}

src_install() {
	java-pkg_newjar "deployment-api.jar"
	use source && java-pkg_dosrc src/java/javax
}
