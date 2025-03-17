#!/bin/bash

FINDUTILS_SRC=$CACHE/findutils
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz" "$FINDUTILS_SRC"

if [ ! -d $FINDUTILS_SRC/build ]
then
  mkdir -p $FINDUTILS_SRC/build
  cd $FINDUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $FINDUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install
