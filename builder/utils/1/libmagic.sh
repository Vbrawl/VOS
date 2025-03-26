#!/bin/bash

LIBMAGIC_SRC=$CACHE/libmagic

$ROOT/download_and_untar.sh "https://astron.com/pub/file/file-5.44.tar.gz" "$LIBMAGIC_SRC"


if [ ! -d $LIBMAGIC_SRC/build ]
then
  mkdir -p $LIBMAGIC_SRC/build
  cd $LIBMAGIC_SRC/build
  ../configure --prefix=/usr --build=$(../config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $LIBMAGIC_SRC/build
make DESTDIR=$ISO_SYSROOT install
