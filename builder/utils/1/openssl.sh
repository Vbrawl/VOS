#!/bin/bash

OPENSSL_SRC=$CACHE/openssl

download_and_untar "https://github.com/openssl/openssl/releases/download/openssl-3.4.1/openssl-3.4.1.tar.gz" "$OPENSSL_SRC"

if [ ! -d $OPENSSL_SRC/build ]
then
  mkdir -p $OPENSSL_SRC/build
  cd $OPENSSL_SRC/build
  ../Configure --cross-compile-prefix=$TARGET- --prefix=/usr
  make -j$(nproc)
fi
cd $OPENSSL_SRC/build
make DESTDIR=$ISO_SYSROOT install
