#!/bin/bash

BB_SRC=$CACHE/busybox
E2FSPROGS_SRC=$CACHE/e2fsprogs

if [ ! -d $BB_SRC ]
then
  git clone git://git.busybox.net/busybox $BB_SRC --depth 1
fi

cd $BB_SRC

if [ ! -f busybox ]
then
  make defconfig
  echo CONFIG_STATIC=y >> $BB_SRC/.config
  make -j$(nproc)
fi

cp $BB_SRC/busybox $BUILD_BIN/busybox
cd $BUILD




if [ ! -d $E2FSPROGS_SRC ]
then
  git clone git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git $E2FSPROGS_SRC --depth 1
fi

cd $E2FSPROGS_SRC

if [ ! -f misc/mke2fs ]
then
  ./configure --disable-nls CFLAGS="--static" LDFLAGS="--static"
  make -j$(nproc)
fi

cp $E2FSPROGS_SRC/misc/mke2fs $BUILD_BIN/mke2fs
