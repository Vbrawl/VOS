#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -f $CROSS_COMPILER_FINISHED ]
then

$ROOT/download_and_untar.sh "https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz" "$COMPILER_SRC"

if [ ! -d $COMPILER_SRC/build ]
then
  mkdir -p $COMPILER_SRC/build
  cd $COMPILER_SRC/build
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER \
              --with-glibc-version=2.41 \
              --with-sysroot=$CACHE_SYSROOT \
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


fi
