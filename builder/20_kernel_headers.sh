#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -f $CROSS_COMPILER_FINISHED ]
then

download_and_untar "https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}.tar.xz" "$KERNEL_SRC"

mkdir -p $CROSS_COMPILER/usr
cd $KERNEL_SRC
make -j$(nproc) mrproper
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$CROSS_COMPILER/usr
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$CACHE_SYSROOT/usr



fi
