#!/bin/bash

SED_SRC=$CACHE/sed
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz" "$SED_SRC"

if [ ! -d $SED_SRC/build ]
then
  mkdir -p $SED_SRC/build
  cd $SED_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $SED_SRC/build
make DESTDIR=$ISO_SYSROOT install
