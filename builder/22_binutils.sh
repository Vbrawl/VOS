#!/bin/bash

BINUTILS_SRC=$CACHE/binutils

if [ ! -d $BINUTILS_SRC ]
then
  git clone git://sourceware.org/git/binutils-gdb.git $BINUTILS_SRC --depth 1
fi

if [ ! -d $BINUTILS_SRC/build ]
then
  mkdir -p $BINUTILS_SRC/build
  cd $BINUTILS_SRC/build
  ../configure --target=$TARGET \
              --with-sysroot=$BUILD_INITRD/fs \
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
