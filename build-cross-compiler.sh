#!/bin/bash

set -e

ROOT=$(pwd)
CACHE=$ROOT/cache
BUILD=$ROOT/build

ARCH=x86_64
TARGET=$ARCH-vos-linux-gnu

KERNEL_SRC=$CACHE/kernel
BINUTILS_SRC=$CACHE/binutils
GCC_SRC=$CACHE/gcc
GLIBC_SRC=$CACHE/glibc
BUILD_FS=$BUILD/initrd_fs/fs
CROSS_COMPILER_DEST=$BUILD_FS/cross-compiler

mkdir -p $CROSS_COMPILER_DEST

mkdir -p $BUILD_FS

# Download sources if needed
if [ ! -d $BINUTILS_SRC ]
then
  git clone git://sourceware.org/git/binutils-gdb.git $BINUTILS_SRC --depth 1
fi

if [ ! -d $GCC_SRC ]
then
  git clone git://gcc.gnu.org/git/gcc.git $GCC_SRC --depth 1
fi

if [ ! -d $GLIBC_SRC ]
then
  git clone https://sourceware.org/git/glibc.git $GLIBC_SRC --depth 1
fi

if [ ! -d $KERNEL_SRC ]
then
  git clone https://github.com/torvalds/linux.git $KERNEL_SRC --depth 1
fi
cp $ROOT/configs/kernel.conf $KERNEL_SRC/.config


# Build binutils
if [ ! -d $BINUTILS_SRC/build ]
then
  mkdir -p $BINUTILS_SRC/build
  cd $BINUTILS_SRC/build
  ../configure --target=$TARGET \
                --with-sysroot=$BUILD_FS \
                --prefix=$CROSS_COMPILER_DEST \
                --disable-nls \
                --disable-gprofng \
                --disable-werror \
                --enable-new-dtags \
                --enable-default-hash-style=gnu
else
  cd $BINUTILS_SRC/build
fi
make -j$(nproc)
make -j$(nproc) install

# Build gcc (Bootstrap)
if [ ! -d $GCC_SRC/build-bootstrap ]
then
  mkdir -p $GCC_SRC/build-bootstrap
  cd $GCC_SRC/build-bootstrap
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER_DEST \
              --with-glibc-version=2.40 \
              --with-sysroot=$BUILD_FS \
              --with-newlib \
              --without-headers \
              --enable-default-pie \
              --enable-default-ssp \
              --disable-nls \
              --disable-shared \
              --disable-multilib \
              --disable-threads \
              --disable-libatomic \
              --disable-libgomp \
              --disable-libquadmath \
              --disable-libssp \
              --disable-libvtv \
              --disable-libstdcxx \
              --enable-languages=c,c++
else
  cd $GCC_SRC/build-bootstrap
fi
make -j$(nproc)
make -j$(nproc) install

# Install kernel headers
mkdir -p $BUILD_FS/usr
cd $KERNEL_SRC
make -j$(nproc) mrproper
make -j$(nproc) ARCH=$ARCH headers_install INSTALL_HDR_PATH=$BUILD_FS/usr

# Build glibc
if [ ! -d $GLIBC_SRC/build ]
then
  mkdir -p $GLIBC_SRC/build
  cd $GLIBC_SRC/build
  ../configure CC=$CROSS_COMPILER_DEST/bin/$TARGET-gcc \
                --prefix=/usr \
                --host=$TARGET \
                --build=$(../scripts/config.guess) \
                --enable-kernel=4.19 \
                --with-headers=$BUILD_FS/usr/include \
                --disable-nscd \
                libc_cv_slibdir=/usr/lib
else
  cd $GLIBC_SRC/build
fi
make || true
make install
