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
cp $BB_SRC/busybox $BUILD_INITRD/bin/busybox
