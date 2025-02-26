#!/bin/bash

BASH_SRC=$CACHE/bash
E2FSPROGS_SRC=$CACHE/e2fsprogs

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
  CC=$CROSS_CC CFLAGS="-Wno-implicit-function-declaration" ./configure --without-bash-malloc
  make -j$(nproc)
fi

mkdir -p $ISO_SYSROOT/bin
cp $BASH_SRC/bash $ISO_SYSROOT/bin/bash



if [ ! -d $E2FSPROGS_SRC ]
then
  git clone git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git $E2FSPROGS_SRC --depth 1
fi

cd $E2FSPROGS_SRC

if [ ! -f misc/mke2fs ]
then
  CC=$CROSS_CC ./configure
  make -j$(nproc)
fi

cp $E2FSPROGS_SRC/misc/mke2fs $ISO_SYSROOT/bin/mke2fs
