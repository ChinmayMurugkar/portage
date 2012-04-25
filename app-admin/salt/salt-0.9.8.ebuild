# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/salt/salt-0.9.8.ebuild,v 1.1 2012/04/24 23:37:27 chutzpah Exp $

EAPI=4

PYTHON_COMPAT="python2_6 python2_7 python3_1 python3_2"

inherit eutils python-distutils-ng

DESCRIPTION="Salt is a remote execution and configuration manager."
HOMEPAGE="http://saltstack.org/"
SRC_URI="mirror://github/saltstack/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+jinja libvirt mongodb mysql redis"

DEPEND=""
RDEPEND="${DEPEND}
		>=dev-python/pyzmq-2.1.9
		dev-python/msgpack
		dev-python/pyyaml
		dev-python/m2crypto
		dev-python/pycrypto
		dev-python/pycryptopp
		jinja? ( dev-python/jinja )
		libvirt? ( app-emulation/libvirt[python] )
		mongodb? ( dev-python/pymongo )
		mysql? ( dev-python/mysql-python )
		redis? ( dev-python/redis-py )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-syndic-resolution-of-master.patch
	sed -i '/install_requires=/ d' setup.py || die "sed failed"

	python-distutils-ng_src_prepare
}

src_install() {
	python-distutils-ng_src_install

	for s in minion master syndic; do
		newinitd "${FILESDIR}"/${s}-initd-1 salt-${s}
		newconfd "${FILESDIR}"/${s}-confd-1 salt-${s}
	done

	# rename the config templates to the actual config names
	for c in "${D}"/etc/${PN}/*.template; do
		mv -f "${c}" "${c%.template}"
		sed -i '1 d' "${c%.template}"
	done

	dodoc README.rst AUTHORS
}

python_test() {
	./setup.py test || die
}
