#!/bin/bash

BINUTILS_SRC=$CACHE/binutils
MPFR_SRC=$CACHE/mpfr
GCC_SRC=$CACHE/gcc
MPFR_SRC=$GCC_SRC/mpfr
GMP_SRC=$GCC_SRC/gmp
MPC_SRC=$GCC_SRC/mpc

$ROOT/download_and_untar.sh "https://sourceware.org/pub/binutils/snapshots/binutils-2.43.90.tar.xz" "$BINUTILS_SRC"
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


download_and_untar "https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz" "$GCC_SRC"
download_and_untar "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz" "$MPFR_SRC"
download_and_untar "https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz" "$MPC_SRC"
download_and_untar "https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz" "$GMP_SRC"
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
