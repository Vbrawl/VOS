#!/bin/bash

INETUTILS_SRC=$CACHE/inetutils

download_and_untar "https://ftp.gnu.org/gnu/inetutils/inetutils-v2.6-src.tar.gz" "$INETUTILS_SRC"

cd $INETUTILS_SRC
./bootstrap

if [ ! -d $INETUTILS_SRC/build ]
then
  cd $INETUTILS_SRC
  ./bootstrap

  mkdir -p $INETUTILS_SRC/build
  cd $INETUTILS_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $INETUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install
