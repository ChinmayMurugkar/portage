# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.5.2.0.ebuild,v 1.5 2012/06/27 14:44:26 ssuominen Exp $

EAPI="4"
GNOME_ORG_MODULE="ModemManager"

inherit gnome.org user multilib

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://cgit.freedesktop.org/ModemManager/ModemManager/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc policykit test"

RDEPEND=">=dev-libs/glib-2.18:2
	|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] )
	>=dev-libs/dbus-glib-0.86
	net-dialup/ppp
	policykit? ( >=sys-auth/polkit-0.99 )"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	# ppp-2.4.5 changes the plugin directory
	if has_version '=net-dialup/ppp-2.4.4*'; then
		pppd_plugin_dir="pppd/2.4.4"
	elif has_version '=net-dialup/ppp-2.4.5*'; then
		pppd_plugin_dir="pppd/2.4.5"
	fi

	econf \
		--disable-more-warnings \
		--with-udev-base-dir=/lib/udev/ \
		--disable-static \
		--with-dist-version=${PVR} \
		--with-pppd-plugin-dir="/usr/$(get_libdir)/${pppd_plugin_dir}" \
		$(use_with doc docs) \
		$(use_with policykit polkit) \
		$(use_with test tests)
}

src_install() {
	default
	use doc && dohtml docs/spec.html

	# Allow users in plugdev group full control over their modem
	if use policykit; then
		if has_version '<sys-auth/polkit-0.106'; then
			insinto /etc/polkit-1/localauthority/10-vendor.d
			doins "${FILESDIR}/01-org.freedesktop.ModemManager.pkla"
		fi
	fi

	# Remove useless .la files
	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	if use policykit; then
		enewgroup plugdev
		elog "To control your modem without needing to enter the root password,"
		elog "add your user account to the 'plugdev' group."
		elog
	fi

	elog "If your USB modem shows up as a Flash drive when you plug it in,"
	elog "You should install sys-apps/usb_modeswitch which will automatically"
	elog "switch it over to USB modem mode whenever you plug it in."
}
