TERMUX_PKG_HOMEPAGE=https://github.com/samtools/htslib
TERMUX_PKG_DESCRIPTION="C library for high-throughput sequencing data formats"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.17
TERMUX_PKG_SRCURL=https://github.com/samtools/htslib/releases/download/${TERMUX_PKG_VERSION}/htslib-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=763779288c40f07646ec7ad98b96c378c739171d162ad98398868783b721839f
TERMUX_PKG_DEPENDS="libbz2, liblzma, zlib, libdeflate"

# error: assigning to 'uint8x8_t' (vector of 8 'uint8_t' values) from incompatible type 'int'
TERMUX_PKG_BLACKLISTED_ARCHES="arm"

termux_step_pre_configure() {
	autoreconf -fi
}
