#!/bin/bash

export ROOT=$(pwd)
export CONFIGS=$ROOT/configs
export BUILDER_SRC=$ROOT/builder

export CACHE=$ROOT/cache
export BUILD=$ROOT/build
export BUILD_INITRD=$BUILD/initrd_fs
export BUILD_SYSTEM_INITRD=$BUILD/system_initrd_fs
export BUILD_ISO=$BUILD/iso
export SYSROOT=$BUILD_INITRD
export CACHE_SYSROOT=$CACHE/sysroot
export ISO_SYSROOT=$BUILD_ISO/fs
export CROSS_COMPILER=$CACHE/cross_cc
export CROSS_COMPILER_FINISHED=$CROSS_COMPILER/complete.flag
export DIST=$ROOT/dist

export LOGRUN=$ROOT/logrun.sh
export LOGS=$ROOT/logs

export KERNEL_MAJOR_VERSION="6"
export KERNEL_MINOR_VERSION="13"
export KERNEL_PATCH_VERSION="4"

export ENDIAN=little
export ARCH=x86_64
export TARGET=$ARCH-vos-linux-gnu
export CROSS_CC=""
export MESON_CROSS_FILE=""
export BOOTLOADER_BIN=""
export BOOTLOADER_CAT=""

export MAGIC_FILE_NAME="MAGIC"
export MAGIC_FILE_HASH=""
