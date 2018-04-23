TERMUX_PKG_HOMEPAGE=https://nim-lang.org/
TERMUX_PKG_DESCRIPTION="Nim programming language compiler"
TERMUX_PKG_VERSION=0.18.0
TERMUX_PKG_SRCURL=https://nim-lang.org/download/nim-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=45c74adb35f08dfa9add1112ae17330e5d902ebb4a36e7046caee8b79e6f3bd0
TERMUX_PKG_HOSTBUILD=yes
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="git, clang, libandroid-glob"
termux_step_host_build() {
	cp ../src/* -r ./
	make -j $TERMUX_MAKE_PROCESSES CC=gcc LD=gcc
	make install
}
termux_step_make() {
	 if [ $TERMUX_ARCH = "x86_64" ]; then
		export	NIM_ARCH=amd64
	elif [ $TERMUX_ARCH = "i686" ]; then
		export	NIM_ARCH=i386
	elif [ $TERMUX_ARCH = "aarch64" ]; then
	# -Oz breaks aarch64 build
		CFLAGS+=" -Os"
		export	NIM_ARCH=arm64
	else 
		export NIM_ARCH=arm
	fi
	LDFLAGS+=" -landroid-glob"
	sed -i "s%\@CC\@%${CC}%g"  config/nim.cfg
	sed -i "s%\@CFLAGS\@%${CFLAGS}%g" config/nim.cfg
	sed -i "s%\@LDFLAGS\@%${LDFLAGS}%g" config/nim.cfg
	sed -i "s%\@CPPFLAGS\@%${CPPFLAGS}%g" config/nim.cfg	
	
	
	#find -name   "stdlib_osproc.c" | xargs -n 1 sed -i 's',"/bin/sh\"\,\ 7","/data/data/com.termux/files/usr/bin/sh\"\,\ 38",'g'
	find -name   "stdlib_osproc.c" | xargs -n 1 sed -i 's',"/system/bin/sh\"\,\ 14","/data/data/com.termux/files/usr/bin/sh\"\,\ 38",'g'
	PATH=$TERMUX_PKG_HOSTBUILD_DIR/bin:$PATH

	if [ $NIM_ARCH = "amd64" ]; then
		sed -i 's/arm64/amd64/g' makefile
	fi
	export CFLAGS=" $CPPFLAGS $CFLAGS  -w  -fno-strict-aliasing"
	make LD=$CC uos=linux mycpu=$NIM_ARCH myos=android  -j $TERMUX_MAKE_PROCESSES useShPath=$TERMUX_PREFIX/bin/sh  
	cp config/nim.cfg ../host-build/config
	
	nim --opt:size --define:termux -d:release --os:android --cpu:$NIM_ARCH  -t:-I/data/data/com.termux/files/usr/include -l:"-L/data/data/com.termux/files/usr/lib -landroid-glob" c koch.nim
	cd dist/nimble/src
	nim --define:termux -d:release --os:android --cpu:$NIM_ARCH  -t:-I/data/data/com.termux/files/usr/include -l:"-L/data/data/com.termux/files/usr/lib -landroid-glob" c nimble.nim
}
termux_step_make_install() {
	./install.sh $TERMUX_PREFIX/lib
	cp dist/nimble/src/nimble $TERMUX_PREFIX/lib/nim/bin
	cp koch $TERMUX_PREFIX/lib/nim/bin
	cp dist/nimble/src/nimble $TERMUX_PREFIX/lib/nim/bin 
	ln -sf $TERMUX_PREFIX/lib/nim/bin/nim $TERMUX_PREFIX/bin
	ln -sf $TERMUX_PREFIX/lib/nim/bin/koch $TERMUX_PREFIX/bin
	ln -sf $TERMUX_PREFIX/lib/nim/bin/nimble $TERMUX_PREFIX/bin
}
