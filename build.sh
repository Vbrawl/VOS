#!/bin/bash

set -e

export ROOT=$(pwd)
export CONFIGS=$ROOT/configs
export BUILDER_SRC=$ROOT/builder

export CACHE=$ROOT/cache
export BUILD=$ROOT/build
export BUILD_USR=$BUILD/usr
export BUILD_BIN=$BUILD_USR/bin
export DIST=$ROOT/dist

export INITRAMFS=""
export BOOTLOADER_BIN=""
export BOOTLOADER_CAT=""

# Clean build directory
if [ -d $BUILD ]
then
  rm -r $BUILD
fi

# Create all directories
mkdir -p $CACHE
mkdir -p $BUILD
mkdir -p $BUILD_USR
mkdir -p $BUILD_BIN
mkdir -p $DIST

# Copy fs
cp -r fs $BUILD

# Copy installer
cp -r installer $BUILD

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
-output $DIST/installer.iso $BUILD
