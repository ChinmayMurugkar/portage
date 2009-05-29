# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kitchensync/kitchensync-3.5.10-r2.ebuild,v 1.1 2009/05/28 14:26:47 tampakrap Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-07.tar.bz2"

DESCRIPTION="Synchronize Data with KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=app-pda/libopensync-0.36
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/libkcal-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	libkdenetwork/
	kontact/interfaces"

# Disabled by default in kontact/plugins/Makefile.am, so check before enabling - 3.4.0_beta1 -- danarmak
# Let's give it a try, as requested in bug #233491.
KMEXTRA="kontact/plugins/kitchensync"
# KMEXTRA="kontact/plugins/multisynk"

PATCHES=( "${WORKDIR}/patches/01_${P}-OpenSync0.30API.patch"
	"${WORKDIR}/patches/02_${P}-xmlparse.diff" )