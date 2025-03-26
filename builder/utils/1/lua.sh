#!/bin/bash

LUA_SRC=$CACHE/lua

$ROOT/download_and_untar.sh "https://www.lua.org/ftp/lua-5.4.7.tar.gz" "$LUA_SRC"

if [ ! -f $LUA_SRC/src/lua ]
then
  cd $LUA_SRC

  patch -p1 < $ROOT/patches/lua.patch
  sed -i '/CC= gcc/s/gcc/${TARGET}-gcc/g' src/Makefile
  make -j$(nproc) SYSCFLAGS="-fPIC"
fi

cd $LUA_SRC
if [ -f Makefile.bak ]
then
  mv Makefile.bak Makefile
fi
sed -i.bak "\|INSTALL_TOP=|s|/usr/local|${ISO_SYSROOT}/usr|g" Makefile
make install
