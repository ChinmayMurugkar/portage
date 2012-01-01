# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/laptop-mode-tools-1.60.ebuild,v 1.1 2012/01/01 16:04:34 hwoarang Exp $

EAPI=2
inherit eutils

MY_P=${PN}_${PV}

DESCRIPTION="Linux kernel laptop_mode user-space utilities"
HOMEPAGE="http://www.samwel.tk/laptop_mode/"
SRC_URI="http://www.samwel.tk/laptop_mode/tools/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="acpi apm bluetooth scsi"

RDEPEND="sys-apps/ethtool
	acpi? ( sys-power/acpid )
	apm? ( sys-apps/apmd )
	bluetooth? ( net-wireless/bluez )
	scsi? ( sys-apps/sdparm )
	sys-apps/hdparm"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Patching to avoid !sys-power/pm-utils depend wrt #327443
	epatch "${FILESDIR}"/${P}-pm-utils-1.4.0.patch
}

src_compile() { :; }

src_install() {
	DESTDIR="${D}" \
		INIT_D="none" \
		MAN_D="/usr/share/man" \
		ACPI="$(use acpi && echo force || echo disabled)" \
		PMU="$(false && echo force || echo disabled)" \
		APM="$(use apm && echo force || echo disabled)" \
		./install.sh || die

	dodoc Documentation/*.txt README || die
	newinitd "${FILESDIR}"/laptop_mode.init-1.4 laptop_mode

	# Commented out to avoid !sys-power/pm-utils depend wrt #327443
	# exeinto /etc/pm/power.d
	# newexe "${FILESDIR}"/laptop_mode_tools.pmutils laptop_mode_tools
}

pkg_postinst() {
	if  use acpi ||  use apm; then
		if use acpi; then
			daemon_name="acpid"
		elif use apm; then
			deamon_name="apmd"
		fi
		ewarn
		ewarn "To enable automatic power state event handling,"
		ewarn "e.g. enabling laptop_mode after unplugging the battery,"
		ewarn "both laptop_mode and the ${daemon_name} daemon"
		ewarn "must be added to a runlevel,"
		ewarn "		rc-update add laptop_mode default"
		ewarn "		rc-update add ${daemon_name} default"
		ewarn
	else
		ewarn
		ewarn "Without USE=\"acpi\" or USE=\"apm\" ${PN} can not"
		ewarn "automatically disable laptop_mode on low battery."
		ewarn
		ewarn "This means you can lose up to 10 minutes of work if running"
		ewarn "out of battery while laptop_mode is enabled."
		ewarn
		ewarn "Please see /usr/share/doc/${PF}/laptop-mode.txt.gz for further"
		ewarn "information."
		ewarn
	fi
}
