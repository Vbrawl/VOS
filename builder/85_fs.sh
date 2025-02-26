#!/bin/bash


if [ -z "$(ls -A $CACHE_SYSROOT)" ]
then
  cp -r $CACHE_SYSROOT/* $SYSROOT
fi
