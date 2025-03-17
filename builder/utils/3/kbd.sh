#!/bin/bash

KBD_SRC=$CACHE/kbd
download_and_untar "https://web.git.kernel.org/pub/scm/linux/kernel/git/legion/kbd.git/snapshot/kbd-2.7.1.tar.gz" "$KBD_SRC"
cd $KBD_SRC
./autogen.sh

if [ ! -d $KBD_SRC/build ]
then
  mkdir -p $KBD_SRC/build
  cd $KBD_SRC/build
  ../configure --prefix=/usr --build=$(../config/config.guess) --host=$TARGET --enable-optional-progs
  make -j$(nproc)
fi
cd $KBD_SRC/build
make DESTDIR=$ISO_SYSROOT install
