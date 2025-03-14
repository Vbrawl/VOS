#!/bin/bash

TAR_SRC=$CACHE/tar
download_and_untar "https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz" "$TAR_SRC"

if [ ! -d $TAR_SRC/build ]
then
  mkdir -p $TAR_SRC/build
  cd $TAR_SRC/build
  ../configure --build=$(../build-aux/config.guess) --host=$TARGET --prefix=/usr
  make -j$(nproc)
fi
cd $TAR_SRC/build
make DESTDIR=$ISO_SYSROOT install
