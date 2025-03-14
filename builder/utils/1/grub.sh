#!/bin/bash

GRUB_SRC=$CACHE/grub
download_and_untar "https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz" "$GRUB_SRC"

if [ ! -d $GRUB_SRC/build ]
then
  mkdir -p $GRUB_SRC/build
  cd $GRUB_SRC/build
  ../configure --prefix=/usr \
                --build=$(../build-aux/config.guess) \
                --host=$TARGET \
                --target=$TARGET
  touch ../grub-core/extra_deps.lst
  make -j$(nproc)
fi
cd $GRUB_SRC/build
make DESTDIR=$ISO_SYSROOT install
