TERMUX_PKG_HOMEPAGE=https://www.dartlang.org/
TERMUX_PKG_DESCRIPTION="Dart is a general-purpose programming language"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="sdk/LICENSE"
TERMUX_PKG_VERSION=2.9.2
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_SKIP_SRC_EXTRACT=true

# Dart uses tar and gzip to extract downloaded packages.
# Busybox-based versions of such utilities cause issues so
# complete ones should be used.
TERMUX_PKG_DEPENDS="gzip, tar"

termux_step_get_source() {
	# UNSAFE
	sudo ln -sf python2 /usr/bin/python

	mkdir -p $TERMUX_PKG_SRCDIR
	cd $TERMUX_PKG_SRCDIR

	git clone --depth=1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
	export PATH="$(pwd)/depot_tools:${PATH}"

	fetch dart

	cd sdk
	git checkout $TERMUX_PKG_VERSION
	cd ../

	echo "target_os = ['android']" >> .gclient
	gclient sync -D --force --reset
}

termux_step_post_get_source() {
	if [ $TERMUX_ARCH = "arm" ]; then
		export DEST_CPU="arm"
	elif [ $TERMUX_ARCH = "i686" ]; then
		export DEST_CPU="ia32"
	elif [ $TERMUX_ARCH = "aarch64" ]; then
		export DEST_CPU="arm64"
	elif [ $TERMUX_ARCH = "x86_64" ]; then
		export DEST_CPU="x64"
	else
		termux_error_exit "Unsupported arch '$TERMUX_ARCH'"
	fi
}

termux_step_make() {
	cd sdk

	rm -f ./out/*/args.gn
	DART_MAKE_PLATFORM_SDK=true python2 ./tools/build.py --mode release --arch=$DEST_CPU --os=android create_sdk
}

termux_step_make_install() {
	cd sdk

	chmod +x ./out/ReleaseAndroid${DEST_CPU}/dart-sdk/bin/*
	cp -r ./out/ReleaseAndroid${DEST_CPU}/dart-sdk ${TERMUX_PREFIX}/lib

	for file in ${TERMUX_PREFIX}/lib/dart-sdk/bin/*; do
		if [[ -f "$file" ]]; then
			echo -e "#!${TERMUX_PREFIX}/bin/sh\nexec $file  \"\$@\"" > ${TERMUX_PREFIX}/bin/$(basename $file)
			chmod +x ${TERMUX_PREFIX}/bin/$(basename $file)
		fi
	done
}

termux_step_post_make_install() {
	install -Dm600 $TERMUX_PKG_BUILDER_DIR/dart-pub-bin.sh \
		$TERMUX_PREFIX/etc/profile.d/dart-pub-bin.sh

	# UNSAFE
	sudo ln -sf python3 /usr/bin/python
}
