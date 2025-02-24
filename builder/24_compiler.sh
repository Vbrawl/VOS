#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -d $COMPILER_SRC/build ]
then
  mkdir -p $COMPILER_SRC/build
  cd $COMPILER_SRC/build
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER \
              --with-glibc-version=2.40 \
              --with-sysroot=$BUILD_INITRD/fs \
              --with-newlib \
              --without-headers \
              --enable-default-pie \
              --enable-default-ssp \
              --disable-nls \
              --disable-shared \
              --disable-multilib \
              --disable-threads \
              --disable-libatomic \
              --disable-libgomp \
              --disable-libquadmath \
              --disable-libssp \
              --disable-libvtv \
              --disable-libstdcxx \
              --enable-languages=c,c++
  make -j$(nproc)
fi
cd $COMPILER_SRC/build
make -j$(nproc) install

export CROSS_CC=$CROSS_COMPILER/bin/$TARGET-gcc
