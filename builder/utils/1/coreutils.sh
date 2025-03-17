#!/bin/bash

CORE_SRC=$CACHE/coreutils
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz" "$CORE_SRC"

if [ ! -d $CORE_SRC/build ]
then
  mkdir -p $CORE_SRC/build
  cd $CORE_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $CORE_SRC/build
make DESTDIR=$ISO_SYSROOT install
