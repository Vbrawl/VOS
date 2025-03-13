#!/bin/bash

OPENRESOLV_SRC=$CACHE/openresolv

if [ ! -d $OPENRESOLV_SRC ]
then
  cd $CACHE
  wget https://github.com/NetworkConfiguration/openresolv/archive/refs/tags/v3.13.2.tar.gz -O openresolv-3.13.2.tar.gz
  tar -xf openresolv-3.13.2.tar.gz
  mv openresolv-3.13.2 $OPENRESOLV_SRC
fi

cd $OPENRESOLV_SRC

if [ ! -f $OPENRESOLV_SRC/resolvconf ]
then
  ./configure --prefix=/usr --target=$TARGET --host=$TARGET
  make -j$(nproc)
fi

make DESTDIR=$ISO_SYSROOT install
