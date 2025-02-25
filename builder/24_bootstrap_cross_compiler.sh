#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -d $COMPILER_SRC ]
then
  cd $CACHE
  wget https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz
  tar -xf gcc-14.2.0.tar.xz
  mv gcc-14.2.0 $COMPILER_SRC
fi

if [ ! -d $COMPILER_SRC/build ]
then
  mkdir -p $COMPILER_SRC/build
  cd $COMPILER_SRC/build
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER \
              --with-glibc-version=2.41 \
              --with-sysroot=$SYSROOT \
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
