#!/bin/bash

FINDUTILS_SRC=$CACHE/findutils

if [ ! -d $FINDUTILS_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz
  tar -xf findutils-4.10.0.tar.xz
  mv findutils-4.10.0 $FINDUTILS_SRC
fi

if [ ! -d $FINDUTILS_SRC/build ]
then
  mkdir -p $FINDUTILS_SRC/build
  cd $FINDUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $FINDUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install
