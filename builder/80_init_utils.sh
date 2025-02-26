#!/bin/bash

BB_SRC=$CACHE/busybox
BASH_SRC=$CACHE/bash
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

if [ ! -d $BASH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz
  tar -xf bash-5.2.37.tar.gz
  mv bash-5.2.37 $BASH_SRC
fi

cd $BASH_SRC

if [ ! -f bash ]
then
  CC=$CROSS_CC CFLAGS="-Wno-implicit-function-declaration" ./configure
  make -j$(nproc)
fi

cp $BASH_SRC/bash $BUILD_INITRD/bin/bash

if [ ! -d $E2FSPROGS_SRC ]
then
  git clone git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git $E2FSPROGS_SRC --depth 1
fi

cd $E2FSPROGS_SRC

if [ ! -f misc/mke2fs ]
then
  ./configure --disable-nls CC=$CROSS_CC
  make -j$(nproc)
fi

cp $E2FSPROGS_SRC/misc/mke2fs $BUILD_INITRD/bin/mke2fs
