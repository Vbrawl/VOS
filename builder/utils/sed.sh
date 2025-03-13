#!/bin/bash

SED_SRC=$CACHE/sed

if [ ! -d $SED_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
  tar -xf sed-4.9.tar.xz
  mv sed-4.9 $SED_SRC
fi


if [ ! -d $SED_SRC/build ]
then
  mkdir -p $SED_SRC/build
  cd $SED_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $SED_SRC/build
make DESTDIR=$ISO_SYSROOT install
