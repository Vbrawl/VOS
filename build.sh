#!/bin/bash

set -e

export ROOT=$(pwd)
export BUILDER_SRC=$ROOT/builder
export CACHE=$ROOT/cache
export BUILD=$ROOT/build
export BUILD_USR=$BUILD/usr
export BUILD_BIN=$BUILD_USR/bin
export DIST=$ROOT/dist

export INITRAMFS=""
export BOOTLOADER_BIN=""
export BOOTLOADER_CAT=""

# Ensure directories exist
if [ ! -d $CACHE ]
then
  mkdir -p $CACHE
fi

if [ ! -d $BUILD ]
then
  mkdir -p $BUILD
fi

if [ ! -d $BUILD_USR ]
then
  mkdir -p $BUILD_USR
fi

if [ ! -d $BUILD_BIN ]
then
  mkdir -p $BUILD_BIN
fi

if [ ! -d $DIST ]
then
  mkdir -p $DIST
fi

# Copy fs
cp -r fs/* $BUILD

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

# FAKE KERNEL
cp /boot/vmlinuz-6.1.0-31-amd64 $BUILD/vmlinuz

genisoimage -rational-rock -volid "VOS Installation Media" -cache-inodes \
-joliet -full-iso9660-filenames -input-charset UTF8 -b $BOOTLOADER_BIN \
-c $BOOTLOADER_CAT -no-emul-boot -boot-load-size 4 -boot-info-table \
-output $DIST/installer.iso $BUILD
