#!/bin/bash

LIBSTDCXX_SRC=$CACHE/gcc/libstdc++-v3

if [ ! -d $LIBSTDCXX_SRC/build ]
then
  mkdir -p $LIBSTDCXX_SRC/build
  cd $LIBSTDCXX_SRC/build

  ../configure --host=$(../../config.guess) \
              --build=$TARGET \
              --prefix=/usr \
              --disable-multilib \
              --disable-nls \
              --disable-libstdcxx-pch \
              --with-gxx-include-dir=$CROSS_COMPILER/$TARGET/c++/15.0.1
  make -j$(nproc)
fi
cd $LIBSTDCXX_SRC/build
make DESTDIR=$CROSS_COMPILER install
