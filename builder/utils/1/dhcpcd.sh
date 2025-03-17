#!/bin/bash

DHCPCD_SRC=$CACHE/dhcpcd
$ROOT/download_and_untar.sh "https://github.com/NetworkConfiguration/dhcpcd/archive/refs/tags/v10.2.2.tar.gz" "$DHCPCD_SRC"

cd $DHCPCD_SRC

if [ ! -f $DHCPCD_SRC/src/dhcpcd ]
then
  ./configure --prefix=/usr --sysconfdir=/etc --target=$TARGET --host=$TARGET --without-udev
  make -j$(nproc)
fi

make DESTDIR=$ISO_SYSROOT install
