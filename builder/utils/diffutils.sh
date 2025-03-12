#!/bin/bash

DIFFUTILS_SRC=$CACHE/diffutils

if [ ! -d $DIFFUTILS_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/diffutils/diffutils-3.11.tar.xz
  tar -xf diffutils-3.11.tar.xz
  mv diffutils-3.11 $DIFFUTILS_SRC
fi

if [ ! -d $DIFFUTILS_SRC/build ]
then
  mkdir -p $DIFFUTILS_SRC/build
  cd $DIFFUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

cd $DIFFUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install
