TERMUX_PKG_HOMEPAGE=https://mosquitto.org/
TERMUX_PKG_DESCRIPTION="MQTT library"
TERMUX_PKG_LICENSE="EPL-1.0"
TERMUX_PKG_MAINTAINER="Nathaniel Wesley Filardo @nwf"
TERMUX_PKG_VERSION=2.0.11
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://mosquitto.org/files/source/mosquitto-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=7b36a7198bce85cf31b132f5c6ee36dcf5dadf86fb768501eb1e11ce95d4f78a
TERMUX_PKG_DEPENDS="c-ares, libc++, libcap, libwebsockets, openssl"
TERMUX_PKG_BREAKS="libmosquitto-dev"
TERMUX_PKG_REPLACES="libmosquitto-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_BUNDLED_DEPS=ON
-DWITH_THREADING=ON
-DWITH_TLS_PSK=OFF
-DWITH_WEBSOCKETS=ON
-DWITH_SRV=ON
"
TERMUX_PKG_SERVICE_SCRIPT=("mosquitto" 'exec mosquitto 2>&1')

termux_step_pre_configure() {
	CFLAGS+=" -DHAVE_PTHREAD_CANCEL=0"
}
