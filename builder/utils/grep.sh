#!/bin/bash

GREP_SRC=$CACHE/grep
download_and_untar "https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz" "$GREP_SRC"

if [ ! -d $GREP_SRC/build ]
then
  mkdir -p $GREP_SRC/build
  cd $GREP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GREP_SRC/build
make DESTDIR=$ISO_SYSROOT install
