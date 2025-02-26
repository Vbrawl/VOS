#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -f $CROSS_COMPILER_FINISHED ]
then



if [ ! -d $KERNEL_SRC ]
then
#  git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
  cd $CACHE
  wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.13.4.tar.xz
  tar -xf linux-6.13.4.tar.xz
  mv linux-6.13.4 $KERNEL_SRC
fi

mkdir -p $CROSS_COMPILER/usr
cd $KERNEL_SRC
make -j$(nproc) mrproper
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$CROSS_COMPILER/usr
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$CACHE_SYSROOT/usr



fi
