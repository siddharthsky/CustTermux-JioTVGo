TERMUX_PKG_HOMEPAGE=https://6xq.net/pianobar/
TERMUX_PKG_DESCRIPTION="pianobar is a free/open-source, console-based client for the personalized online radio Pandora."
TERMUX_PKG_VERSION=2018.06.22
TERMUX_PKG_REVISION=0
TERMUX_PKG_SHA256=a616ef70c04ceea8294caaba091d6a16bf35293bdc587151a235fb0e6a00ad90
TERMUX_PKG_SRCURL=https://github.com/PromyLOPh/pianobar/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_DEPENDS="libao, ffmpeg, libgcrypt, libcurl, json-c"
TERMUX_PKG_BUILD_DEPENDS="libao-dev, ffmpeg-dev, libgcrypt-dev, libcurl-dev, json-c-dev, pkg-config"
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_post_make_install () {
  #fix no sound issue when pulseaudio started by libao
  cat $TERMUX_PREFIX/bin/pulseaudio \
  | sed 's/pulseaudio\ \$@/pianobar\ \$@/' \
  > $TERMUX_PREFIX/bin/pianobar
  chmod +x $TERMUX_PREFIX/bin/pianobar
}
