# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/libav/libav-0.8.9999.ebuild,v 1.14 2012/05/14 09:16:01 scarabeus Exp $

EAPI=4

if [[ ${PV} == *9999 ]] ; then
	SCM="git-2"
	EGIT_REPO_URI="git://git.libav.org/libav.git"
	[[ ${PV%9999} != "" ]] && EGIT_BRANCH="release/${PV%.9999}"
fi

inherit eutils flag-o-matic multilib toolchain-funcs ${SCM}

DESCRIPTION="Complete solution to record, convert and stream audio and video."
HOMEPAGE="http://libav.org/"
if [[ ${PV} == *9999 ]] ; then
	SRC_URI=""
elif [[ ${PV%_p*} != ${PV} ]] ; then # Gentoo snapshot
	SRC_URI="http://dev.gentoo.org/~lu_zero/libav/${P}.tar.xz"
else # Official release
	SRC_URI="http://${PN}.org/releases/${P}.tar.xz"
fi

LICENSE="LGPL-2.1  gpl? ( GPL-3 )"
SLOT="0"
[[ ${PV} == *9999 ]] || KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64
~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos
~x64-solaris ~x86-solaris"
IUSE=" aac aacplus alsa ass amr bindist +bzip2 cdio celt cpudetection
	custom-cflags dirac debug doc +encode faac frei0r +gpl gsm
	+hardcoded-tables ieee1394 jack jpeg2k libv4l modplug mp3 network
	openal openssl oss pic pulseaudio rtmp schroedinger sdl speex ssl
	static-libs test theora threads truetype v4l vaapi vdpau vorbis
	vpx X x264 xvid +zlib"

# String for CPU features in the useflag[:configure_option] form
# if :configure_option isn't set, it will use 'useflag' as configure option
CPU_FEATURES="3dnow:amd3dnow 3dnowext:amd3dnowext altivec avx mmx mmxext:mmx2 neon ssse3 vis"

for i in ${CPU_FEATURES}; do
	IUSE+=" ${i%:*}"
done

RDEPEND="
	!media-video/ffmpeg
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	ass? ( media-libs/libass )
	bzip2? ( app-arch/bzip2 )
	cdio? ( dev-libs/libcdio )
	celt? ( >=media-libs/celt-0.11.1 )
	dirac? ( media-video/dirac )
	encode? (
		aac? ( media-libs/vo-aacenc )
		aacplus? ( media-libs/libaacplus )
		amr? ( media-libs/vo-amrwbenc )
		faac? ( media-libs/faac )
		mp3? ( >=media-sound/lame-3.98.3 )
		theora? (
			>=media-libs/libtheora-1.1.1[encode]
			media-libs/libogg
		)
		vorbis? ( media-libs/libvorbis media-libs/libogg )
		x264? ( >=media-libs/x264-0.0.20111017 )
		xvid? ( >=media-libs/xvid-1.1.0 )
	)
	frei0r? ( media-plugins/frei0r-plugins )
	gsm? ( >=media-sound/gsm-1.0.12-r1 )
	ieee1394? (
		media-libs/libdc1394
		sys-libs/libraw1394
	)
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg2k? ( >=media-libs/openjpeg-1.3-r2 )
	libv4l? ( media-libs/libv4l )
	modplug? ( media-libs/libmodplug )
	openal? ( >=media-libs/openal-1.1 )
	pulseaudio? ( media-sound/pulseaudio )
	rtmp? ( >=media-video/rtmpdump-2.2f )
	ssl? (
		openssl? ( dev-libs/openssl )
		!openssl? ( net-libs/gnutls )
	)
	sdl? ( >=media-libs/libsdl-1.2.13-r1[audio,video] )
	schroedinger? ( media-libs/schroedinger )
	speex? ( >=media-libs/speex-1.2_beta3 )
	truetype? ( media-libs/freetype:2 )
	vaapi? ( x11-libs/libva )
	vdpau? ( x11-libs/libvdpau )
	vpx? ( >=media-libs/libvpx-0.9.6 )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
	)
	zlib? ( sys-libs/zlib )
"

DEPEND="${RDEPEND}
	>=sys-devel/make-3.81
	dirac? ( virtual/pkgconfig )
	doc? ( app-text/texi2html )
	ieee1394? ( virtual/pkgconfig )
	libv4l? ( virtual/pkgconfig )
	mmx? ( dev-lang/yasm )
	rtmp? ( virtual/pkgconfig )
	schroedinger? ( virtual/pkgconfig )
	ssl? ( virtual/pkgconfig )
	test? ( net-misc/wget )
	truetype? ( virtual/pkgconfig )
	v4l? ( sys-kernel/linux-headers )
"

# faac can't be binary distributed
# openssl support marked as nonfree
# faac and aac are concurent implementations
# amr and aac require at least lgpl3
# x264 requires gpl2
REQUIRED_USE="bindist? ( !aacplus !faac !openssl )
	rtmp? ( network )
	amr? ( gpl ) aac? ( gpl ) x264? ( gpl ) X? ( gpl )
	test? ( encode zlib )
"

src_prepare() {
	# if we have snapshot then we need to hardcode the version
	if [[ ${PV%_p*} != ${PV} ]]; then
		sed -i -e "s/UNKNOWN/DATE-${PV#*_pre}/" "${S}/version.sh" || die
	fi
}

src_configure() {
	local myconf="${EXTRA_LIBAV_CONF}"
	local uses i

	myconf+="
		$(use_enable gpl)
		$(use_enable gpl version3)
		--enable-avfilter
	"

	# enabled by default
	uses="debug doc network zlib"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use bzip2 || myconf+=" --disable-bzlib"
	use sdl || myconf+=" --disable-avplay"

	if use ssl; then
		use openssl && myconf+=" --enable-openssl --enable-nonfree" \
			|| myconf+=" --enable-gnutls"
	fi

	use custom-cflags && myconf+=" --disable-optimizations"
	use cpudetection && myconf+=" --enable-runtime-cpudetect"

	use vdpau || myconf+=" --disable-vdpau"

	use vaapi && myconf+=" --enable-vaapi"

	# Encoders
	if use encode; then
		use aacplus && myconf+=" --enable-nonfree"
		use faac && myconf+=" --enable-nonfree"
		use mp3 && myconf+=" --enable-libmp3lame"
		use amr && myconf+=" --enable-libvo-amrwbenc"
		use aac && myconf+=" --enable-libvo-aacenc"
		uses="aacplus faac theora vorbis x264 xvid"
		for i in ${uses}; do
			use ${i} && myconf+=" --enable-lib${i}"
		done
	else
		myconf+=" --disable-encoders"
	fi

	# libavdevice options
	use cdio && myconf+=" --enable-libcdio"
	use ieee1394 && myconf+=" --enable-libdc1394"
	use openal && myconf+=" --enable-openal"
	use pulseaudio && myconf+=" --enable-libpulse"

	# Indevs
	# v4l1 is gone since linux-headers-2.6.38
	myconf+=" --disable-indev=v4l"
	use v4l || myconf+=" --disable-indev=v4l2"
	for i in alsa oss jack; do
		use ${i} || myconf+=" --disable-indev=${i}"
	done
	use X && myconf+=" --enable-x11grab"
	use libv4l && myconf=" --enable-libv4l2"
	# Outdevs
	for i in alsa oss ; do
		use ${i} || myconf+=" --disable-outdev=${i}"
	done
	# libavfilter options
	use ass && myconf+=" --enable-libass"
	use frei0r && myconf+=" --enable-frei0r"
	use truetype &&  myconf+=" --enable-libfreetype"

	# Threads; we only support pthread for now but ffmpeg supports more
	use threads && myconf+=" --enable-pthreads"

	# Decoders
	use amr && myconf+=" --enable-libopencore-amrwb --enable-libopencore-amrnb"
	uses="celt gsm modplug rtmp schroedinger speex vpx"
	for i in ${uses}; do
		use ${i} && myconf+=" --enable-lib${i}"
	done
	use jpeg2k && myconf+=" --enable-libopenjpeg"

	# CPU features
	for i in ${CPU_FEATURES}; do
		use ${i%:*} || myconf+=" --disable-${i#*:}"
	done

	# pass the right -mfpu as extra
	use neon && myconf+=" --extra-cflags=-mfpu=neon"

	# disable mmx accelerated code if PIC is required
	# as the provided asm decidedly is not PIC for x86.
	if use pic && use x86 ; then
		myconf+=" --disable-mmx --disable-mmx2"
	fi

	# Option to force building pic
	use pic && myconf+=" --enable-pic"

	# Try to get cpu type based on CFLAGS.
	# Bug #172723
	# We need to do this so that features of that CPU will be better used
	# If they contain an unknown CPU it will not hurt since ffmpeg's configure
	# will just ignore it.
	for i in $(get-flag march) $(get-flag mcpu) $(get-flag mtune) ; do
		[[ "${i}" == "native" ]] && i="host" # bug #273421
		myconf+=" --cpu=${i}"
		break
	done

	# cross compile support
	if tc-is-cross-compiler ; then
		myconf+=" --enable-cross-compile --arch=$(tc-arch-kernel) --cross-prefix=${CHOST}-"
		case ${CHOST} in
			*freebsd*)
				myconf+=" --target-os=freebsd"
				;;
			mingw32*)
				myconf+=" --target-os=mingw32"
				;;
			*linux*)
				myconf+=" --target-os=linux"
				;;
		esac
	fi

	# Misc stuff
	use hardcoded-tables && myconf+=" --enable-hardcoded-tables"

	# Specific workarounds for too-few-registers arch...
	if [[ $(tc-arch) == "x86" ]]; then
		filter-flags -fforce-addr -momit-leaf-frame-pointer
		append-flags -fomit-frame-pointer
		is-flag -O? || append-flags -O2
		if use debug; then
			# no need to warn about debug if not using debug flag
			ewarn ""
			ewarn "Debug information will be almost useless as the frame pointer is omitted."
			ewarn "This makes debugging harder, so crashes that has no fixed behavior are"
			ewarn "difficult to fix. Please have that in mind."
			ewarn ""
		fi
	fi

	cd "${S}"
	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--shlibdir="${EPREFIX}"/usr/$(get_libdir) \
		--mandir="${EPREFIX}"/usr/share/man \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--ar="$(tc-getAR)" \
		--optflags="${CFLAGS}" \
		--extra-cflags="${CFLAGS}" \
		$(use_enable static-libs static) \
		${myconf} || die
}

src_compile() {
	local i

	emake

	for i in ${FFTOOLS} ; do
		use fftools_${i} && emake tools/${i}
		done
}

src_install() {
	local i
	emake DESTDIR="${D}" install install-man

	dodoc Changelog README INSTALL
	dodoc doc/*.txt
	use doc && dodoc doc/*.html

	for i in ${FFTOOLS} ; do
		use fftools_${i} && dobin tools/${i}
		done

	for i in $(usex sdl avplay "") $(usex network avserver "") avprobe; do
		dosym  ${i} /usr/bin/${i/av/ff}
	done
}

pkg_postinst() {
	elog "Please note that the programs formerly known as ffplay, ffserver"
	elog "and ffprobe are now called avplay, avserver and avprobe."
	elog
	elog "ffmpeg had been replaced by the feature incompatible avconv"
}

src_test() {
	LD_LIBRARY_PATH="${S}/libavcore:${S}/libpostproc:${S}/libswscale:${S}/libavcodec:${S}/libavdevice:${S}/libavfilter:${S}/libavformat:${S}/libavutil" \
		emake V=1 -j1 fate
}
