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
export OS=vos
export TARGET=$ARCH-$OS-linux-gnu

export CROSS_CC=$CROSS_COMPILER/bin/$TARGET-gcc
export MESON_CROSS_FILE=$CROSS_COMPILER/cross_cc.meson
export CMAKE_CROSS_FILE=$CROSS_COMPILER/cross_cc.cmake

export MAGIC_FILE_NAME="MAGIC"
export MAGIC_FILE_HASH="" # Can't be known here

export PATH=$CROSS_COMPILER/bin:$PATH
export PKG_CONFIG_PATH=
export PKG_CONFIG_LIBDIR=$ISO_SYSROOT/usr/lib/pkgconfig:$ISO_SYSROOT/usr/share/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$ISO_SYSROOT
export CFLAGS="--sysroot=$ISO_SYSROOT -I$ISO_SYSROOT/usr/include"
