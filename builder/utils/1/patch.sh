#!/bin/bash

PATCH_SRC=$CACHE/patch
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz" "$PATCH_SRC"

if [ ! -d $PATCH_SRC/build ]
then
  mkdir -p $PATCH_SRC/build
  cd $PATCH_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $PATCH_SRC/build
make DESTDIR=$ISO_SYSROOT install
