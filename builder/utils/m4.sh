#!/bin/bash

M4_SRC=$CACHE/m4


if [ ! -d $M4_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz
  tar -xf m4-1.4.19.tar.xz
  mv m4-1.4.19 $M4_SRC
fi

if [ ! -d $M4_SRC/build ]
then
  mkdir -p $M4_SRC/build
  cd $M4_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $M4_SRC/build
make DESTDIR=$ISO_SYSROOT install
