#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -d $KERNEL_SRC ]
then
  git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
fi

mkdir -p $CROSS_COMPILER/usr
cd $KERNEL_SRC
make -j$(nproc) mrproper
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$CROSS_COMPILER/usr
