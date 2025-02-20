#!/bin/bash

KERNEL_SRC=$CACHE/kernel

if [ ! -d $KERNEL_SRC ]
then
  git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
fi

cd $KERNEL_SRC


if [ ! -f $KERNEL_SRC/arch/x86_64/boot/bzImage ]
then
  make defconfig

  sed -i '/CONFIG_SCSI_MOD/s/.*/CONFIG_SCSI_MOD=y/'
  sed -i '/CONFIG_SCSI_COMMON=/s/.*/CONFIG_SCSI_COMMON=y/'
  sed -i '/CONFIG_SCSI=/s/.*/CONFIG_SCSI=y/'
  sed -i '/CONFIG_SCSI_DMA=/s/.*/CONFIG_SCSI_DMA=y/'
  sed -i '/CONFIG_SCSI_PROC_FS=/s/.*/CONFIG_SCSI_PROC_FS=y/'

  make
fi

cp $KERNEL_SRC/arch/x86_64/boot/bzImage $BUILD/vmlinuz
