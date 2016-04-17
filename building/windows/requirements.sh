#!/bin/bash

# using: https://github.com/coinzen/devcoin/blob/master/doc/build-mingw-under_linux.txt as a guide
# Note: This assumes ubuntu:14.04 and we are going to cross-compile the windows binaries

sudo apt-get --yes -qq install software-properties-common > /dev/null
sudo add-apt-repository --yes ppa:ubuntu-sdk-team/ppa > /dev/null
sudo add-apt-repository --yes ppa:bitcoin/bitcoin > /dev/null
sudo apt-get update -qq > /dev/null

# add the cross compiling stuffs
sudo apt-get --yes -qq install dpkg-dev git sudo make mingw-w64 mingw-w64-common wget g++-mingw-w64 binutils-mingw-w64-x86-64 g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64 mingw-w64-tools mingw-w64-x86-64-dev zip nsis binutils-mingw-w64-i686 g++-mingw-w64-i686 gcc-mingw-w64-i686 mingw-w64-i686-dev mingw32 mingw32-binutils mingw32-runtime > /dev/null

# base requirements for building wallet (pulled from linux)
sudo apt-get --yes -qq install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git libboost-all-dev libminiupnpc-dev libprotobuf-dev protobuf-compiler libqrencode-dev protobuf-compiler autoconf bsdmainutils python curl > /dev/null

./building/${VERGE_PLATFORM}/req_openssl.sh
#./building/${VERGE_PLATFORM}/req_pthreads.sh
./building/${VERGE_PLATFORM}/req_dbd.sh
./building/${VERGE_PLATFORM}/req_miniupnpc.sh
./building/${VERGE_PLATFORM}/req_protobuf.sh
./building/${VERGE_PLATFORM}/req_boost.sh
./building/${VERGE_PLATFORM}/req_qrencode.sh
./building/${VERGE_PLATFORM}/req_zlib.sh
./building/${VERGE_PLATFORM}/req_qt.sh
