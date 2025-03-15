#!/bin/bash

INETUTILS_SRC=$CACHE/inetutils

download_and_untar "https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz" "$INETUTILS_SRC"

if [ ! -d $INETUTILS_SRC/build ]
then
  mkdir -p $INETUTILS_SRC/build
  cd $INETUTILS_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess) --enable-year2038
  cat >> $INETUTILS_SRC/build/config.h << EOF
#ifndef PATH_PROCNET_DEV
#define PATH_PROCNET_DEV "/proc/net/dev"
#endif PATH_PROCNET_DEV
EOF
  make -j$(nproc)
fi
cd $INETUTILS_SRC/build

# Tries to install executables as root.
# We manually mark everything as 755 to avoid any problems.
make DESTDIR=$ISO_SYSROOT install || true
chmod 755 $ISO_SYSROOT/usr/bin/{ping,ping6,rcp,rlogin,rsh,traceroute,ifconfig}
