#!/bin/bash


if [ -n "$(ls -A $CACHE_SYSROOT)" ]
then
  cp -r $CACHE_SYSROOT/* $SYSROOT

  rm -r $SYSROOT/var
  rm -r $SYSROOT/usr/share
  rm -r $SYSROOT/usr/include
  rm -r $SYSROOT/etc
  rm -r $SYSROOT/usr/bin
  rm -r $SYSROOT/sbin
  rm -r $SYSROOT/usr/sbin
  rm -r $SYSROOT/usr/libexec

  cd $SYSROOT/usr/lib
  ls | grep -v -E "(libc.so.6|ld-linux-x86-64.so.2)" | xargs rm -r
fi
