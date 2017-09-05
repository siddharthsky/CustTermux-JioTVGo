TERMUX_PKG_HOMEPAGE=https://www.metasploit.com/
TERMUX_PKG_DESCRIPTION="framework for pentesting"
TERMUX_PKG_VERSION=4.16.2
# Depend on coreutils for bin/env
TERMUX_PKG_DEPENDS="wget, ruby, curl, autoconf, bison, clang, coreutils, curl, findutils, git, libffi-dev, libgmp-dev, libpcap-dev, postgresql-dev, readline-dev, libsqlite-dev, openssl-dev, libtool, libxml2-dev, libxslt-dev, ncurses-dev, pkg-config, postgresql-contrib, wget, make, ruby-dev, libgrpc-dev, termux-tools, ncurses-utils, ncurses, unzip, zip, tar, autoconf "
TERMUX_PKG_PLATFORM_INDEPENDENT=no

termux_step_make_install () {
	
	
        cd $PREFIX/share/
        apt update
        cd $PREFIX/share/
        curl -LO https://github.com/rapid7/metasploit-framework/archive/4.16.2.tar.gz
        tar -xf $PREFIX/share/4.16.4.tar.gz
        mv $PREFIX/share/metasploit-framework-4.16.4 $PREFIX/share/metasploit-framework
        cd $PREFIX/share/metasploit-framework
        sed '/rbnacl/d' -i Gemfile.lock
        sed '/rbnacl/d' -i metasploit-framework.gemspec
        gem install bundler


        gem install nokogiri -- --use-system-libraries

        sed 's|grpc (.*|grpc (1.4.1)|g' -i $PREFIX/share/metasploit-framework/Gemfile.lock
        gem unpack grpc -v 1.4.1
        cd grpc-1.4.1
        curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
        curl -L https://wiki.termux.com/images/b/bf/Grpc_extconf.patch -o extconf.patch
        patch -p1 < extconf.patch
        gem build grpc.gemspec
        gem install grpc-1.4.1.gem
        cd ..
        rm -r grpc-1.4.1


        cd $PREFIX/share/metasploit-framework
        bundle install -j5

        $PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
        ln -s $PREFIX/share/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
} 
