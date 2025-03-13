#!/bin/bash

BINUTILS_SRC=$CACHE/binutils
MPFR_SRC=$CACHE/mpfr
GCC_SRC=$CACHE/gcc
MPFR_SRC=$GCC_SRC/mpfr
GMP_SRC=$GCC_SRC/gmp
MPC_SRC=$GCC_SRC/mpc


if [ ! -d $BINUTILS_SRC ]
then
  cd $CACHE
  wget https://sourceware.org/pub/binutils/snapshots/binutils-2.43.90.tar.xz
  tar -xf binutils-2.43.90.tar.xz
  mv binutils-2.43.90 $BINUTILS_SRC
fi


if [ ! -d $BINUTILS_SRC/build_final ]
then
  mkdir -p $BINUTILS_SRC/build_final
  cd $BINUTILS_SRC/build_final
  ../configure --prefix=/usr \
                --host=$TARGET \
                --target=$TARGET \
                --build=$(../config.guess) \
                --with-build-sysroot=$ISO_SYSROOT \
                --enable-static \
                --enable-64-bit-bfd \
                --disable-nls \
                --disable-gprofng \
                --disable-werror \
                --enable-new-dtags \
                --enable-default-hash-style=gnu
  make -j$(nproc)
fi
cd $BINUTILS_SRC/build_final
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $GCC_SRC ]
then
  cd $CACHE
  wget https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz
  tar -xf gcc-14.2.0.tar.xz
  mv gcc-14.2.0 $GCC_SRC
fi

if [ ! -d $MPFR_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz
  tar -xf mpfr-4.2.1.tar.xz
  mv mpfr-4.2.1 $MPFR_SRC
fi

if [ ! -d $MPC_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
  tar -xf mpc-1.3.1.tar.gz
  mv mpc-1.3.1 $MPC_SRC
fi

if [ ! -d $GMP_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
  tar -xf gmp-6.3.0.tar.xz
  mv gmp-6.3.0 $GMP_SRC
fi


if [ ! -d $GCC_SRC/build_final ]
then
  mkdir -p $GCC_SRC/build_final
  cd $GCC_SRC/build_final
  ../configure --prefix=/usr \
                --host=$TARGET \
                --target=$TARGET \
                --build=$(../config.guess) \
                LDFLAGS_FOR_TARGET=-L$PWD/$TARGET/libgcc \
                --with-glibc-version=2.41 \
                --with-build-sysroot=$ISO_SYSROOT \
                --enable-default-pie \
                --enable-default-ssp \
                --disable-nls \
                --disable-multilib \
                --disable-libsanitizer \
                --disable-libvtv \
                --disable-libssp \
                --disable-libquadmath \
                --disable-libgomp \
                --disable-libatomic \
                --enable-year2038 \
                --enable-languages=c,c++
  make -j$(nproc)
fi
cd $GCC_SRC/build_final
make DESTDIR=$ISO_SYSROOT install
