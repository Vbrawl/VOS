#!/bin/bash

GREP_SRC=$CACHE/grep

if [ ! -d $GREP_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz
  tar -xf grep-3.11.tar.xz
  mv grep-3.11 $GREP_SRC
fi

if [ ! -d $GREP_SRC/build ]
then
  mkdir -p $GREP_SRC/build
  cd $GREP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GREP_SRC/build
make DESTDIR=$ISO_SYSROOT install
