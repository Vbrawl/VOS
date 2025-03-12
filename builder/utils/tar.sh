#!/bin/bash

TAR_SRC=$CACHE/tar

if [ ! -d $TAR_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
  tar -xf tar-1.35.tar.xz
  mv tar-1.35 $TAR_SRC
fi

if [ ! -d $TAR_SRC/build ]
then
  mkdir -p $TAR_SRC/build
  cd $TAR_SRC/build
  ../configure --build=$(../build-aux/config.guess) --host=$TARGET --prefix=/usr
  make -j$(nproc)
fi
cd $TAR_SRC/build
make DESTDIR=$ISO_SYSROOT install
