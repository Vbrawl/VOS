#!/bin/bash


if [ -n "$(ls -A $CACHE_SYSROOT)" ]
then
  cp -r $CACHE_SYSROOT/* $ISO_SYSROOT
fi
