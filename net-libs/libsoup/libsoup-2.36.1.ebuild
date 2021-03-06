# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-2.36.1.ebuild,v 1.10 2012/05/05 02:54:27 jdhore Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="An HTTP library implementation in C"
HOMEPAGE="http://live.gnome.org/LibSoup"

LICENSE="LGPL-2"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="debug doc +introspection samba ssl test"

# glib-networking-2.29.18 needed to avoid a tls bug, see NEWS file
RDEPEND=">=dev-libs/glib-2.30.0:2
	>=dev-libs/libxml2-2:2
	>=net-libs/glib-networking-2.30.0[ssl?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	samba? ( net-fs/samba )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/gtk-doc-am-1.10
	doc? ( >=dev-util/gtk-doc-1.10 )"
#	test? (	www-servers/apache[ssl,apache2_modules_auth_digest,apache2_modules_alias,apache2_modules_auth_basic,
#		apache2_modules_authn_file,apache2_modules_authz_host,apache2_modules_authz_user,apache2_modules_dir,
#		apache2_modules_mime,apache2_modules_proxy,apache2_modules_proxy_http,apache2_modules_proxy_connect]
#		dev-lang/php[apache2,xmlrpc]
#		net-misc/curl
#		net-libs/glib-networking[ssl])"

pkg_setup() {
	# Set invalid apache module dir until apache tests are ready, bug #326957
	DOCS="AUTHORS NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--disable-tls-check
		--without-gnome
		--with-apache-module-dir="${T}"
		$(use_enable introspection)
		$(use_with samba ntlm-auth ${EPREFIX}/usr/bin/ntlm_auth)"
}

src_configure() {
	# FIXME: we need addpredict to workaround bug #324779 until
	# root cause (bug #249496) is solved
	addpredict /usr/share/snmp/mibs/.index
	gnome2_src_configure
}

src_prepare() {
	if ! use test; then
		# don't waste time building tests (bug #226271)
		sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed failed"
	fi

	# Patch *must* be applied conditionally (see patch for details)
	if use doc; then
		# Fix bug 268592 (upstream #573685) (build fails without gnome && doc)
		epatch "${FILESDIR}/${PN}-2.34.2-fix-build-without-gnome-with-doc.patch"
		eautoreconf
	fi

	gnome2_src_prepare
}
