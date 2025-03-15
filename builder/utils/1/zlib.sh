#!/bin/bash

ZLIB_SRC=$CACHE/zlib

download_and_untar "https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.xz" "$ZLIB_SRC"

if [ ! -d $ZLIB_SRC/build ]
then
  mkdir -p $ZLIB_SRC/build
  cd $ZLIB_SRC/build
  CHOST=$TARGET ../configure --prefix=/usr --64
  make -j$(nproc)
fi
cd $ZLIB_SRC/build
make DESTDIR=$ISO_SYSROOT install
