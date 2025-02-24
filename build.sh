#!/bin/bash

set -e

export ROOT=$(pwd)
export CONFIGS=$ROOT/configs
export BUILDER_SRC=$ROOT/builder

export CACHE=$ROOT/cache
export CROSS_COMPILER=$CACHE/cross-gcc
export BUILD=$ROOT/build
export BUILD_INITRD=$BUILD/initrd_fs
export BUILD_ISO=$BUILD/iso
export DIST=$ROOT/dist

export ARCH=x86_64
export TARGET=$ARCH-vos-linux-gnu
export CROSS_CC=""
export BOOTLOADER_BIN=""
export BOOTLOADER_CAT=""

# Clean build directory
if [ -d $BUILD ]
then
  rm -r $BUILD
fi

# Create all directories
mkdir -p $CACHE
mkdir -p $CROSS_COMPILER
mkdir -p $BUILD
mkdir -p $BUILD_INITRD
mkdir -p $BUILD_ISO
mkdir -p $DIST

# Execute all scripts
for s in $BUILDER_SRC/*.sh
do
  source $s
done


if [ -z "${BOOTLOADER_BIN}" ]
then
  echo "No bootloader bin found!"
  exit
fi

if [ -z "${BOOTLOADER_CAT}" ]
then
  echo "No bootloader cat found!"
  exit
fi

genisoimage -rational-rock -volid "VOS Installation Media" -cache-inodes \
-joliet -full-iso9660-filenames -input-charset UTF8 -b $BOOTLOADER_BIN \
-c $BOOTLOADER_CAT -no-emul-boot -boot-load-size 4 -boot-info-table \
-output $DIST/installer.iso $BUILD_ISO
