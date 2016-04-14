#!/bin/bash

# Note: This assumes ubuntu:14.04 and we are going to cross-compile the windows binaries

sudo apt-get --yes install software-properties-common
sudo add-apt-repository --yes ppa:ubuntu-sdk-team/ppa
sudo add-apt-repository --yes ppa:bitcoin/bitcoin
sudo apt-get update -qq

pwd

# using: https://github.com/coinzen/devcoin/blob/master/doc/build-mingw-under_linux.txt as a guide

#sudo apt-get --yes upgrade 
#sudo apt-get --yes update
sudo apt-get --yes install dpkg-dev git sudo make mingw-w64 mingw-w64-common wget g++-mingw-w64 binutils-mingw-w64-x86-64 g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64 mingw-w64-tools mingw-w64-x86-64-dev

sudo apt-get --yes install software-properties-common
sudo add-apt-repository --yes ppa:ubuntu-sdk-team/ppa
sudo add-apt-repository --yes ppa:bitcoin/bitcoin
#sudo apt-get --yes update -qq

# TODO: perhaps put each of these 4 requirements in their own bash file (to see how travis will roll up the log files)
# build openssl
echo "=== Building openssl now..."
cd /tmp/
sudo apt-get source openssl
# TODO: need to determine directory/version automatically
cd /tmp/openssl-1.0.1f
CROSS_COMPILE="x86_64-w64-mingw32-" ./Configure mingw64 no-asm shared --prefix=/opt/mingw64 
PATH=$PATH:/usr/i686-w64-mingw32/bin make depend
PATH=$PATH:/usr/i686-w64-mingw32/bin make

# build Berkeley DB v4.8
echo "=== Building BDB now..."
cd /tmp
# Note: would be nice if 'apt-get source libdbd4.8' (or similar) would work
wget 'https://launchpad.net/~bitcoin/+archive/ubuntu/bitcoin/+files/db4.8_4.8.30.orig.tar.gz' -O db4.8_4.8.30.orig.tar.gz
# Note: Could pull it from Oracle like this: wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
tar xzf db4.8_4.8.30.orig.tar.gz
cd /tmp/db-4.8.30/build_unix
PATH=$PATH:/usr/i686-w64-mingw32/bin sh ../dist/configure --host=i686-w64-mingw32 --enable-cxx --enable-mingw --disable-replication
PATH=$PATH:/usr/i686-w64-mingw32/bin make

# miniupnpc 
echo "=== Building MINIUPNPC now..."
cd /tmp
wget 'http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpc-1.6.tar.gz' -O /tmp/miniupnpc-1.6.tar.gz
tar xzf miniupnpc-1.6.tar.gz
cd /tmp/miniupnpc-1.6
sed -i 's/CC = gcc/CC = i686-w64-mingw32-gcc/' Makefile.mingw
sed -i 's/wingenminiupnpcstrings \$/wine \.\/wingenminiupnpcstrings \$/' Makefile.mingw
sed -i 's/dllwrap/i686-w64-mingw32-dllwrap/' Makefile.mingw
sed -i 's/wine /.\/updateminiupnpcstrings.sh #/' Makefile.mingw
sed -i 's/-enable-stdcall-fixup/-Wl,-enable-stdcall-fixup/' Makefile.mingw
sed -i 's/driver-name gcc/driver-name i686-w64-mingw32-gcc/' Makefile.mingw
sed -i 's/; miniupnpc library/miniupnpc/' miniupnpc.def
AR=i686-w64-mingw32-ar make -f Makefile.mingw

# boost
echo "=== Building BOOST now..."
cd /tmp
wget wget 'http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.bz2/download' -O boost_1_60_0.tar.bz2
tar jxf boost_1_60_0.tar.bz2
cd /tmp/boost_1_60_0
./bootstrap.sh --without-icu
echo "using gcc : 4.9.2 : i686-w64-mingw32-g++ : <rc>i686-w64-mingw32-windres <archiver>i686-w64-mingw32-ar ;" > user-config.jam
sed -i 's/ -Wunused-local-typedefs//' ./libs/core/test/Jamfile.v2
sed -i 's/40700/10/' ./boost/tuple/detail/tuple_basic.hpp
sed -i 's/#.*//' libs/context/src/unsupported.cpp
./b2 -j10 --user-config=user-config.jam toolset=gcc-mingw address-model=32 binary-format=pe target-os=windows release --prefix=/usr/i686-w64-mingw32/local --without-python --without-wave --without-context --without-coroutine --without-mpi --without-test --without-graph --without-graph_parallel -sNO_BZIP2=1
sed -i 's/ -Wunused-local-typedefs//' ./libs/core/test/Jamfile.v2
./b2 -j10 --user-config=user-config.jam toolset=gcc-mingw address-model=32 binary-format=pe target-os=windows release --prefix=/usr/i686-w64-mingw32/local --without-python --without-wave --without-context --without-coroutine --without-mpi --without-test --without-graph --without-graph_parallel -sNO_BZIP2=1

# qt4  (see https://wiki.qt.io/MinGW-64-bit )
# considering... https://sourceforge.net/projects/mingwbuilds/files/mingw-sources/4.8.1/src-4.8.1-release-rev5.tar.7z/download
# also considering using the apt-get source ...
echo "=== Building QT now..."
sudo apt-get --yes install unzip libqt4-dev
cd /tmp
wget http://download.qt.io/archive/qt/4.8/4.8.5/qt-everywhere-opensource-src-4.8.5.zip
unzip qt-everywhere-opensource-src-4.8.5.zip
cd /tmp/qt-everywhere-opensource-src-4.8.5

# build wallet
#cd /tmp
#git clone https://github.com/vergecurrency/verge 
#cd verge

# TODO: more work here...

