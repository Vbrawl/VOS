#!/bin/bash

INETUTILS_SRC=$CACHE/inetutils

download_and_untar "https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz" "$INETUTILS_SRC"

if [ ! -d $INETUTILS_SRC/build ]
then
  mkdir -p $INETUTILS_SRC/build
  cd $INETUTILS_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess) --enable-year2038 --disable-ifconfig
  make -j$(nproc)
fi
cd $INETUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install
