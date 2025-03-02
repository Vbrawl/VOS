#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -f $CROSS_COMPILER_FINISHED ]
then



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
              --with-sysroot=$CACHE_SYSROOT \
              --disable-multilib \
              --disable-nls \
              --enable-languages=c,c++
  make -j$(nproc)
fi
cd $COMPILER_SRC/build-full
make -j$(nproc) install

touch $CROSS_COMPILER_FINISHED
ln -s $TARGET-gcc $CROSS_COMPILER/bin/$TARGET-cc

fi

export CROSS_CC=$CROSS_COMPILER/bin/$TARGET-gcc
