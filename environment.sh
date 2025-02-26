#!/bin/bash

export ROOT=$(pwd)
export CONFIGS=$ROOT/configs
export BUILDER_SRC=$ROOT/builder

export CACHE=$ROOT/cache
export BUILD=$ROOT/build
export BUILD_INITRD=$BUILD/initrd_fs
export BUILD_ISO=$BUILD/iso
export SYSROOT=$BUILD_INITRD
export CACHE_SYSROOT=$CACHE/sysroot
export CROSS_COMPILER=$CACHE/cross_cc
export CROSS_COMPILER_FINISHED=$CROSS_COMPILER/complete.flag
export DIST=$ROOT/dist


export ARCH=x86_64
export TARGET=$ARCH-vos-linux-gnu
export CROSS_CC=""
export BOOTLOADER_BIN=""
export BOOTLOADER_CAT=""

export MAGIC_FILE_NAME="MAGIC"
export MAGIC_FILE_HASH=""
