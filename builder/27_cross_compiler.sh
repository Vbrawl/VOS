#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -d $COMPILER_SRC ]
then
  cd $CACHE
  wget https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz
  tar -xf gcc-14.2.0.tar.xz
  mv gcc-14.2.0 $COMPILER_SRC
fi

if [ ! -d $COMPILER_SRC/build-full ]
then
  mkdir -p $COMPILER_SRC/build-full
  cd $COMPILER_SRC/build-full
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER \
              --with-glibc-version=2.41 \
              --with-sysroot=$SYSROOT \
              --disable-multilib \
              --disable-nls \
              --enable-languages=c,c++
  make
fi
cd $COMPILER_SRC/build-full
make -j$(nproc) install

ln -sf ../usr/lib/ld-linux-x86-64.so.2 $SYSROOT/lib64/ld-linux-x86-64.so.2

export CROSS_CC=$CROSS_COMPILER/bin/$TARGET-gcc
