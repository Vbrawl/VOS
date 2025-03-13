#!/bin/bash

DHCPCD_SRC=$CACHE/dhcpcd

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
  ./configure --prefix=/usr --target=$TARGET --host=$TARGET --without-udev
  make -j$(nproc)
fi

make DESTDIR=$ISO_SYSROOT install
