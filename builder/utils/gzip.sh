#!/bin/bash

GZIP_SRC=$CACHE/gzip

if [ ! -d $GZIP_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz
  tar -xf gzip-1.13.tar.xz
  mv gzip-1.13 $GZIP_SRC
fi

if [ ! -d $GZIP_SRC/build ]
then
  mkdir -p $GZIP_SRC/build
  cd $GZIP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GZIP_SRC/build
make DESTDIR=$ISO_SYSROOT install
