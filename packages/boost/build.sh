TERMUX_PKG_HOMEPAGE=https://boost.org
TERMUX_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
TERMUX_PKG_VERSION=1.66.0
#TERMUX_PKG_SHA256=9807a5d16566c57fd74fb522764e0b134a8bbe6b6e8967b83afefd30dcd3be81
TERMUX_PKG_SHA256=5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9
TERMUX_PKG_SRCURL=https://sourceforge.net/projects/boost/files/boost/${TERMUX_PKG_VERSION}/boost_${TERMUX_PKG_VERSION//./_}.tar.bz2
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libbz2, liblzma"
TERMUX_PKG_REVISION=1
termux_step_make_install() {
	rm $TERMUX_PREFIX/lib/libboost* -f
	rm $TERMUX_PREFIX/include/boost -rf

	./bootstrap.sh --with-python=/usr/bin/python3 

	echo "using clang : $TERMUX_ARCH : $CXX : <linkflags>-L/data/data/com.termux/files/usr/lib ; " >> project-config.jam

	./b2 target-os=android -j${TERMUX_MAKE_PROCESSES} \
		include=/data/data/com.termux/files/usr/include \
		include=/data/data/com.termux/files/usr/include/python3.6m \
		toolset=clang-$TERMUX_ARCH \
		python=3.6 \
		--prefix="$TERMUX_PREFIX"  \
		-q \
		--without-stacktrace \
		--without-coroutine \
		--without-context \
		--without-log \
		--disable-icu \
		cxxflags="$CXXFLAGS" \
		link=shared \
		threading=multi \
		install

}
