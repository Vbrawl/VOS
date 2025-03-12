#!/bin/bash

CORE_SRC=$CACHE/coreutils

if [ ! -d $CORE_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz
  tar -xf coreutils-9.6.tar.xz
  mv coreutils-9.6 $CORE_SRC
fi

if [ ! -d $CORE_SRC/build ]
then
  mkdir -p $CORE_SRC/build
  cd $CORE_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $CORE_SRC/build
make DESTDIR=$ISO_SYSROOT install
