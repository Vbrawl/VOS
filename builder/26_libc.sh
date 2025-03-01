#!/bin/bash

GLIBC_SRC=$CACHE/glibc

if [ ! -f $CROSS_COMPILER_FINISHED ]
then



if [ ! -d $GLIBC_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/glibc/glibc-2.41.tar.xz
  tar -xf glibc-2.41.tar.xz
  mv glibc-2.41 $GLIBC_SRC
fi

if [ ! -d $GLIBC_SRC/build ]
then
  mkdir -p $GLIBC_SRC/build
  cd $GLIBC_SRC/build
  ../configure CC=$CROSS_CC \
              --prefix=/usr \
              --host=$TARGET \
              --build=$(../scripts/config.guess) \
              --enable-kernel=4.19 \
              --with-headers=$CROSS_COMPILER/usr/include \
              --disable-nscd \
              libc_cv_slibdir=/usr/lib
  make -j$(nproc) || true
fi
cd $GLIBC_SRC/build
make -j$(nproc) DESTDIR=$CACHE_SYSROOT install
mkdir -p $CACHE_SYSROOT/lib64
ln -sf /usr/lib/ld-linux-x86-64.so.2 $CACHE_SYSROOT/lib64/ld-linux-x86-64.so.2
ln -sf ld-linux-x86-64.so.2 $CACHE_SYSROOT/usr/lib/ld-linux.so.2

fi
