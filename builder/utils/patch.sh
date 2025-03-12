#!/bin/bash

PATCH_SRC=$CACHE/patch

if [ ! -d $PATCH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz
  tar -xf patch-2.7.6.tar.xz
  mv patch-2.7.6 $PATCH_SRC
fi

if [ ! -d $PATCH_SRC/build ]
then
  mkdir -p $PATCH_SRC/build
  cd $PATCH_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $PATCH_SRC/build
make DESTDIR=$ISO_SYSROOT install
