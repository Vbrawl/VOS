#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -d $KERNEL_SRC ]
then
  cd $CACHE
  wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux/6.13.4.tar.xz
  tar -xf linux-6.13.4.tar.xz
  mv linux-6.13.4 $KERNEL_SRC
  #git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
fi

cd $KERNEL_SRC


if [ ! -f $KERNEL_SRC/arch/x86_64/boot/bzImage ]
then
  cp $CONFIGS/kernel.conf $KERNEL_SRC/.config
  make -j$(nproc) ARCH=$ARCH CC=$CROSS_CC
fi

cp $KERNEL_SRC/arch/x86_64/boot/bzImage $BUILD_ISO/vmlinuz
