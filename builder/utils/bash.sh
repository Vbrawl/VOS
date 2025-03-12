#!/bin/bash

BASH_SRC=$CACHE/bash

if [ ! -d $BASH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz
  tar -xf bash-5.2.37.tar.gz
  mv bash-5.2.37 $BASH_SRC
  chmod +x $BASH_SRC/support/config.guess
fi

if [ ! -d $BASH_SRC/build ]
then
  mkdir -p $BASH_SRC/build
  cd $BASH_SRC/build
  CFLAGS="-Wno-implicit-function-declaration" ../configure --prefix=/usr --without-bash-malloc --build=$(../support/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $BASH_SRC/build
make DESTDIR=$ISO_SYSROOT install

mkdir -p $ISO_SYSROOT/bin
ln -sf /bin/bash $ISO_SYSROOT/bin/sh
