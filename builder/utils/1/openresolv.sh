#!/bin/bash

OPENRESOLV_SRC=$CACHE/openresolv
download_and_untar "https://github.com/NetworkConfiguration/openresolv/archive/refs/tags/v3.13.2.tar.gz" "$OPENRESOLV_SRC"
cd $OPENRESOLV_SRC

if [ ! -f $OPENRESOLV_SRC/resolvconf ]
then
  ./configure --prefix=/usr --sysconfdir=/etc --target=$TARGET --host=$TARGET
  make -j$(nproc)
fi

make DESTDIR=$ISO_SYSROOT install
