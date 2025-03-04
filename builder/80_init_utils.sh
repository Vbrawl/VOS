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
  cp $CONFIGS/busybox.conf $BB_SRC/.config
  make -j$(nproc) CC=$CROSS_CC
fi

mkdir -p $BUILD_INITRD/bin
mkdir -p $BUILD_SYSTEM_INITRD/bin
cp $BB_SRC/busybox $BUILD_INITRD/bin/busybox
cp $BB_SRC/busybox $BUILD_SYSTEM_INITRD/bin/busybox

if [ ! -d $E2FSPROGS_SRC ]
then
  git clone git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git $E2FSPROGS_SRC --depth 1
fi

cd $E2FSPROGS_SRC

if [ ! -f misc/mke2fs ]
then
  CC=$CROSS_CC CFLAGS="--static" LDFLAGS="--static" ./configure
  make -j$(nproc)
fi

cp $E2FSPROGS_SRC/misc/mke2fs $BUILD_INITRD/bin/mke2fs
