#!/bin/bash

BASH_SRC=$CACHE/bash

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
