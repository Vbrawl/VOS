#!/bin/bash

XZ_SRC=$CACHE/xz
download_and_untar "https://github.com/tukaani-project/xz/releases/download/v5.6.4/xz-5.6.4.tar.xz" "$XZ_SRC"

if [ ! -d $XZ_SRC/build ]
then
  mkdir -p $XZ_SRC/build
  cd $XZ_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-static
  make -j$(nproc)
fi
cd $XZ_SRC/build
make DESTDIR=$ISO_SYSROOT install
