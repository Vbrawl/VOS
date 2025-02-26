#!/bin/bash

cd $BUILD_INITRD

cp -r $CACHE_SYSROOT/* $SYSROOT
find * | cpio -o --format=newc > $BUILD_ISO/initrd
