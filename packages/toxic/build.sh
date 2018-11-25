TERMUX_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
TERMUX_PKG_DESCRIPTION="A command line client for Tox"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=0.8.3
TERMUX_PKG_SHA256=97f26ba2c257c10439fd2ff280ca90c37ed225d86f46740a08f02ff2e4459e0e
TERMUX_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/v${TERMUX_PKG_VERSION}/toxic-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_REVISION=1
TERMUX_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libqrencode, ncurses, libfreealut"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	make \
		PREFIX="${TERMUX_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}" \
		CHECK_AUDIO_LIBS=1
}

termux_step_make_install() {
	make PREFIX="${TERMUX_PREFIX}" install
	mv $TERMUX_PREFIX/bin/toxic $TERMUX_PREFIX/libexec/toxic
	local SYSTEM_LIBFOLDER=lib64
	if [ $TERMUX_ARCH_BITS = 32 ]; then SYSTEM_LIBFOLDER=lib; fi
	echo "#!/bin/sh" > $TERMUX_PREFIX/bin/toxic
	echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIBFOLDER:/system/vendor/$SYSTEM_LIBFOLDER:$TERMUX_PREFIX/lib exec $TERMUX_PREFIX/libexec/toxic \"\$@\"" >> $TERMUX_PREFIX/bin/toxic
	chmod +x $TERMUX_PREFIX/bin/toxic
}
