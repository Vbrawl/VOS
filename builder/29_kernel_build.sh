#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -d $KERNEL_SRC ]
then
  cd $CACHE
  wget https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux/${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}.tar.xz
  tar -xf linux-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}.tar.xz
  mv linux-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION} $KERNEL_SRC
fi

cd $KERNEL_SRC


if [ ! -f $KERNEL_SRC/arch/x86_64/boot/bzImage ]
then
  cp $CONFIGS/kernel.conf $KERNEL_SRC/.config
  make -j$(nproc) ARCH=$ARCH CC=$CROSS_CC
fi

cp $KERNEL_SRC/arch/x86_64/boot/bzImage $BUILD_ISO/vmlinuz-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}
