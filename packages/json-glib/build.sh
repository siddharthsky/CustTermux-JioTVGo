TERMUX_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/JsonGlib
TERMUX_PKG_DESCRIPTION="GLib JSON manipulation library"
local _MAJOR_VERSION=1.2
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.8
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/json-glib/${_MAJOR_VERSION}/json-glib-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=fd55a9037d39e7a10f0db64309f5f0265fa32ec962bf85066087b83a2807f40a
TERMUX_PKG_DEPENDS="glib"

termux_step_pre_configure() {
	LDFLAGS+=" -lintl -landroid-support -liconv"
}
