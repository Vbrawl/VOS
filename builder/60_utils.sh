#!/bin/bash

export PATH=$CROSS_COMPILER/bin:$PATH
export PKG_CONFIG_PATH=
export PKG_CONFIG_LIBDIR=$ISO_SYSROOT/usr/lib/pkgconfig:$ISO_SYSROOT/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$ISO_SYSROOT
export CFLAGS="--sysroot=$ISO_SYSROOT"

for phase in $ROOT/builder/utils/*
do
  for f in $phase/*.sh
  do
    $LOGRUN $f &
  done
  wait
done
