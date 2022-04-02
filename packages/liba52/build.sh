TERMUX_PKG_HOMEPAGE=https://liba52.sourceforge.io/
TERMUX_PKG_DESCRIPTION="A52 (ac-3) decoder"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.7.4
TERMUX_PKG_REVISION=0
TERMUX_PKG_SRCURL=https://liba52.sourceforge.io/files/a52dec-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a21d724ab3b3933330194353687df82c475b5dfb997513eef4c25de6c865ec33 
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-oss --enable-shared"
