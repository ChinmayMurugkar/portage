# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kmid/kmid-0.2.1.ebuild,v 1.2 2010/03/15 13:11:59 ssuominen Exp $

EAPI=2
KDE_LINGUAS="cs da de en_GB es fr gl pt_BR pt sv uk"
inherit kde4-base

DESCRIPTION="a MIDI/Karaoke player for KDE"
HOMEPAGE="http://userbase.kde.org/KMid2"
SRC_URI="mirror://sourceforge/kmid2/kmid2-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug +handbook"

DEPEND="media-libs/alsa-lib"

S=${WORKDIR}/kmid2-${PV}

DOCS="ChangeLog README TODO"
