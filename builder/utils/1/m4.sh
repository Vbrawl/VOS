#!/bin/bash

M4_SRC=$CACHE/m4
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz" "$M4_SRC"

if [ ! -d $M4_SRC/build ]
then
  mkdir -p $M4_SRC/build
  cd $M4_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $M4_SRC/build
make DESTDIR=$ISO_SYSROOT install
