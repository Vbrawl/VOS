#!/bin/bash

MAKE_SRC=$CACHE/make

if [ ! -d $MAKE_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
  tar -xf make-4.4.1.tar.gz
  mv make-4.4.1 $MAKE_SRC
fi

if [ ! -d $MAKE_SRC/build_dir ]
then
  mkdir -p $MAKE_SRC/build_dir
  cd $MAKE_SRC/build_dir
  ../configure --prefix=/usr --without-guile --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $MAKE_SRC/build_dir
make DESTDIR=$ISO_SYSROOT install
