#!/bin/bash

XZ_SRC=$CACHE/xz

if [ ! -d $XZ_SRC ]
then
  cd $CACHE
  wget https://github.com/tukaani-project/xz/releases/download/v5.6.4/xz-5.6.4.tar.xz
  tar -xf xz-5.6.4.tar.xz
  mv xz-5.6.4 $XZ_SRC
fi

if [ ! -d $XZ_SRC/build ]
then
  mkdir -p $XZ_SRC/build
  cd $XZ_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-static
  make -j$(nproc)
fi
cd $XZ_SRC/build
make DESTDIR=$ISO_SYSROOT install
