#!/bin/bash

set -e

source environment.sh

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
mkdir -p $CACHE_SYSROOT
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
