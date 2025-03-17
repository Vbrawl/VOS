#!/bin/bash

LIBXCRYPT_SRC=$CACHE/libxcrypt

$ROOT/download_and_untar.sh "https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz" "$LIBXCRYPT_SRC"

if [ ! -d $LIBXCRYPT_SRC/build ]
then
  mkdir -p $LIBXCRYPT_SRC/build
  cd $LIBXCRYPT_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/m4-autogen/config.guess) --host=$TARGET --enable-year2038
  make -j$(nproc)
fi
cd $LIBXCRYPT_SRC/build
make DESTDIR=$ISO_SYSROOT install
