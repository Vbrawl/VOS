#!/bin/bash

CORE_SRC=$CACHE/coreutils
BASH_SRC=$CACHE/bash

if [ ! -d $CORE_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz
  tar -xf coreutils-9.6.tar.xz
  mv coreutils-9.6 $CORE_SRC
fi

cd $CORE_SRC

if [ ! -f $CORE_SRC/Makefile ]
then
  CC=$CROSS_CC ./configure
  make -j$(nproc) || true
fi

cd $CORE_SRC/src
mkdir -p $ISO_SYSROOT/bin
for f in $(find * -type f -executable)
do
  cp $f $ISO_SYSROOT/bin/$f
done


if [ ! -d $BASH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz
  tar -xf bash-5.2.37.tar.gz
  mv bash-5.2.37.tar.gz $BASH_SRC
fi

cd $BASH_SRC

if [ ! -f bash ]
then
  CC=$CROSS_CC CFLAGS="-Wno-implicit-function-declaration" ./configure --without-bash-malloc
  make -j$(nproc)
fi

mkdir -p $ISO_SYSROOT/bin
cp $BASH_SRC/bash $ISO_SYSROOT/bin/bash
