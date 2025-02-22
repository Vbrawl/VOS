#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -d $KERNEL_SRC ]
then
  git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
fi

cd $KERNEL_SRC


if [ ! -f $KERNEL_SRC/arch/x86_64/boot/bzImage ]
then
  cp $CONFIGS/kernel.conf $KERNEL_SRC/.config
  make -j$(nproc)
fi

cp $KERNEL_SRC/arch/x86_64/boot/bzImage $BUILD/vmlinuz
