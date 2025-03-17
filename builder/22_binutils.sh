#!/bin/bash

BINUTILS_SRC=$CACHE/binutils

if [ ! -f $CROSS_COMPILER_FINISHED ]
then

$ROOT/download_and_untar.sh "https://sourceware.org/pub/binutils/snapshots/binutils-2.43.90.tar.xz" "$BINUTILS_SRC"

if [ ! -d $BINUTILS_SRC/build ]
then
  mkdir -p $BINUTILS_SRC/build
  cd $BINUTILS_SRC/build
  ../configure --target=$TARGET \
              --with-sysroot=$CACHE_SYSROOT \
              --prefix=$CROSS_COMPILER \
              --disable-nls \
              --disable-gprofng \
              --disable-werror \
              --enable-new-dtags \
              --enable-default-hash-style=gnu
  make -j$(nproc)
fi
cd $BINUTILS_SRC/build
make -j$(nproc) install


fi
