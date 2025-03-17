#!/bin/bash

MAKE_SRC=$CACHE/make
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz" "$MAKE_SRC"

if [ ! -d $MAKE_SRC/build_dir ]
then
  mkdir -p $MAKE_SRC/build_dir
  cd $MAKE_SRC/build_dir
  ../configure --prefix=/usr --without-guile --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $MAKE_SRC/build_dir
make DESTDIR=$ISO_SYSROOT install
