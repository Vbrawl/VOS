#!/bin/bash

BB_SRC=$CACHE/busybox

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

#for s in ls cat pwd mount umount mkdir touch rm
#do
#  ln -s /usr/bin/busybox usr/bin/$s
#done
