# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vhba/vhba-20110915.ebuild,v 1.7 2012/05/24 04:20:30 vapier Exp $

EAPI="4"

inherit eutils linux-mod user

MY_P=vhba-module-${PV}
DESCRIPTION="Virtual (SCSI) Host Bus Adapter kernel module for the CDEmu suite"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

RDEPEND=">=sys-fs/udev-125"
DEPEND=""

S=${WORKDIR}/${MY_P}
MODULE_NAMES="vhba(block:${S})"
BUILD_TARGETS=all

pkg_setup() {
	CONFIG_CHECK="~BLK_DEV_SR ~CHR_DEV_SG"
	check_extra_config
	BUILD_PARAMS="KDIR=${KV_DIR}"
	linux-mod_pkg_setup

	enewgroup cdemu
}

src_prepare() {
	# Build failure with >=3.4-rc1 and CONFIG_ENABLE_WARN_DEPRECATED, #411459
	epatch "${FILESDIR}/${P}-3.4-kmap_atomic.patch"
	# Avoid "make jobserver unavailable" warning
	sed -e 's:\t$(KMAKE):\t+$(KMAKE):g' -i Makefile || die "sed failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README
	linux-mod_src_install

	einfo "Generating udev rules ..."
	dodir /lib/udev/rules.d/
	cat > "${D}"/lib/udev/rules.d/70-vhba.rules <<-EOF || die
	# do not edit this file, it will be overwritten on update
	#
	KERNEL=="vhba_ctl", MODE="0660", OWNER="root", GROUP="cdemu"
	EOF
}

pkg_postinst() {
	elog "Don't forget to add your user to the cdemu group if you want to"
	elog "be able to use virtual cdemu devices."

	# Older versions of vhba installed their rule file in /etc/udev/rules.d,
	# which overrides rules in /lib/udev/rules.d. We remove the old file
	# automatically if it is identical to the default one installed by
	# vhba-1.2.1 or 20101015-r1. Note that the comment at the top of the rules
	# file states that it can be automatically overwritten by the system.
	old_rules="${ROOT}etc/udev/rules.d/70-vhba.rules"
	if [[ -f "${old_rules}" ]]; then
		case "$(md5sum ${old_rules})" in
		  2959b3cf61cfe6e466cc3516a7bc19de* | 1e7a7e5d6d28c811eeec98ec26ed5d28* )
		  	elog
			elog "Removing old ${old_rules} ..."
			rm -f "${old_rules}" ||
				eerror "Failed, please remove ${old_rules} manually."
			;;
		  * )
			ewarn
			ewarn "The ${old_rules} file from a previous"
			ewarn "installation of ${PN} is overriding ${P}'s"
			ewarn "udev rules. Unless you had deliberately customized it,"
			ewarn "you should remove it."
			ewarn
			;;
		esac
	fi

	linux-mod_pkg_postinst
}
