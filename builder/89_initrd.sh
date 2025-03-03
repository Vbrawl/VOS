#!/bin/bash

cd $BUILD_INITRD

find * | cpio -o --format=newc > $BUILD_ISO/initrd-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}
