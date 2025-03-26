#!/bin/bash

LIBARCHIVE_SRC=$CACHE/libarchive

$ROOT/download_and_untar.sh "https://github.com/libarchive/libarchive/releases/download/v3.7.8/libarchive-3.7.8.tar.gz" "$LIBARCHIVE_SRC"

if [ ! -d $LIBARCHIVE_SRC/builddir ]
then
  cd $LIBARCHIVE_SRC
  cmake -Bbuilddir -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CROSS_FILE -DCMAKE_INSTALL_PREFIX=/usr
  cmake --build builddir
fi
cd $LIBARCHIVE_SRC
DESTDIR=$ISO_SYSROOT cmake --install builddir
