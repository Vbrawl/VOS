#!/bin/bash

DHCPCD_SRC=$CACHE/dhcpcd
OPENRESOLV_SRC=$CACHE/openresolv

if [ ! -d $DHCPCD_SRC ]
then
  cd $CACHE
  wget https://github.com/NetworkConfiguration/dhcpcd/archive/refs/tags/v10.2.2.tar.gz -O dhcpcd-10.2.2.tar.gz
  tar -xf dhcpcd-10.2.2.tar.gz
  mv dhcpcd-10.2.2 $DHCPCD_SRC
fi

cd $DHCPCD_SRC

if [ ! -f $DHCPCD_SRC/src/dhcpcd ]
then
  ./configure --prefix=/usr --target=$TARGET --host=$TARGET
  make -j$(nproc)
fi

make DESTDIR=$ISO_SYSROOT install


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
