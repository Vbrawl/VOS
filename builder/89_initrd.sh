#!/bin/bash

cd $BUILD_INITRD

find * | cpio -o --format=newc > $BUILD_ISO/initrd
