#!/bin/bash

GZIP_SRC=$CACHE/gzip
download_and_untar "https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz" $GZIP_SRC

if [ ! -d $GZIP_SRC/build ]
then
  mkdir -p $GZIP_SRC/build
  cd $GZIP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GZIP_SRC/build
make DESTDIR=$ISO_SYSROOT install
