#!/bin/bash

GAWK_SRC=$CACHE/gawk

if [ ! -d $GAWK_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/gawk/gawk-5.3.1.tar.xz
  tar -xf gawk-5.3.1.tar.xz
  mv gawk-5.3.1 $GAWK_SRC
fi

if [ ! -d $GAWK_SRC/build ]
then
  mkdir -p $GAWK_SRC/build
  cd $GAWK_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GAWK_SRC/build
make DESTDIR=$ISO_SYSROOT install
