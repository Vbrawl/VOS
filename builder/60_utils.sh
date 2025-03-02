#!/bin/bash

CORE_SRC=$CACHE/coreutils
BASH_SRC=$CACHE/bash
M4_SRC=$CACHE/m4
NCURSES_SRC=$CACHE/ncurses
DIFFUTILS_SRC=$CACHE/diffutils
FINDUTILS_SRC=$CACHE/findutils
GAWK_SRC=$CACHE/gawk
GREP_SRC=$CACHE/grep
GZIP_SRC=$CACHE/gzip
MAKE_SRC=$CACHE/make
PATCH_SRC=$CACHE/patch
SED_SRC=$CACHE/sed
TAR_SRC=$CACHE/tar
XZ_SRC=$CACHE/xz

BINUTILS_SRC=$CACHE/binutils
MPFR_SRC=$CACHE/mpfr
GCC_SRC=$CACHE/gcc
MPFR_SRC=$GCC_SRC/mpfr
GMP_SRC=$GCC_SRC/gmp
MPC_SRC=$GCC_SRC/mpc

export PATH=$CROSS_COMPILER/bin:$PATH

if [ ! -d $CORE_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz
  tar -xf coreutils-9.6.tar.xz
  mv coreutils-9.6 $CORE_SRC
fi

cd $CORE_SRC

if [ ! -f $CORE_SRC/Makefile ]
then
  ./configure --host=$TARGET --build=$(./build-aux/config.guess)
  make -j$(nproc)
fi

cd $CORE_SRC/src
mkdir -p $ISO_SYSROOT/bin
for f in $(find * -type f -executable)
do
  cp $f $ISO_SYSROOT/bin/$f
done


if [ ! -d $BASH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz
  tar -xf bash-5.2.37.tar.gz
  mv bash-5.2.37 $BASH_SRC
fi

cd $BASH_SRC

if [ ! -f bash ]
then
  CFLAGS="-Wno-implicit-function-declaration" ./configure --without-bash-malloc --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

mkdir -p $ISO_SYSROOT/bin
cp $BASH_SRC/bash $ISO_SYSROOT/bin/bash
ln -sf /bin/bash $ISO_SYSROOT/bin/sh

if [ ! -d $M4_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz
  tar -xf m4-1.4.19.tar.xz
  mv m4-1.4.19 $M4_SRC
fi

if [ ! -d $M4_SRC/build ]
then
  mkdir -p $M4_SRC/build
  cd $M4_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $M4_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $NCURSES_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz
  tar -xf ncurses-6.5.tar.gz
  mv ncurses-6.5 $NCURSES_SRC
fi

if [ ! -d $NCURSES_SRC/build-tic ]
then
  mkdir -p $NCURSES_SRC/build-tic
  cd $NCURSES_SRC/build-tic
  ../configure
  make -j$(nproc) -C include
  make -j$(nproc) -C progs tic
fi

if [ ! -d $NCURSES_SRC/buildw ]
then
  mkdir -p $NCURSES_SRC/buildw
  cd $NCURSES_SRC/buildw
  ../configure --prefix=/usr \
                --build=$(../config.guess) \
                --host=$TARGET \
                --with-shared \
                --without-debug \
                --without-normal \
                --with-cxx-shared \
                --without-ada \
                --disable-stripping
  make -j$(nproc)
fi

if [ ! -d $NCURSES_SRC/build ]
then
  mkdir -p $NCURSES_SRC/build
  cd $NCURSES_SRC/build
  ../configure --prefix=/usr \
                --build=$(../config.guess) \
                --host=$TARGET \
                --disable-widec \
                --with-shared \
                --without-debug \
                --without-normal \
                --with-cxx-shared \
                --without-ada \
                --disable-stripping
  make -j $(nproc)
fi

cd $NCURSES_SRC/build
make DESTDIR=$ISO_SYSROOT TIC_PATH=$NCURSES_SRC/build-tic/progs/tic install
cd $NCURSES_SRC/buildw
make DESTDIR=$ISO_SYSROOT TIC_PATH=$NCURSES_SRC/build-tic/progs/tic install



if [ ! -d $DIFFUTILS_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/diffutils/diffutils-3.11.tar.xz
  tar -xf diffutils-3.11.tar.xz
  mv diffutils-3.11 $DIFFUTILS_SRC
fi

if [ ! -d $DIFFUTILS_SRC/build ]
then
  mkdir -p $DIFFUTILS_SRC/build
  cd $DIFFUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

cd $DIFFUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $FINDUTILS_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz
  tar -xf findutils-4.10.0.tar.xz
  mv findutils-4.10.0 $FINDUTILS_SRC
fi

if [ ! -d $FINDUTILS_SRC/build ]
then
  mkdir -p $FINDUTILS_SRC/build
  cd $FINDUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $FINDUTILS_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $GAWK_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/gawk/gawk-5.3.1.tar.xz
  tar -xf gawk-5.3.1.tar.xz
  mv gawk-5.3.1 $GAWK_SRC
fi

if [ ! -d $GAWK_SRC/build ]
then
  mkdir -p $GAWK_SRC/build
  cd $GAWK_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GAWK_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $GREP_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz
  tar -xf grep-3.11.tar.xz
  mv grep-3.11 $GREP_SRC
fi

if [ ! -d $GREP_SRC/build ]
then
  mkdir -p $GREP_SRC/build
  cd $GREP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GREP_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $GZIP_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz
  tar -xf gzip-1.13.tar.xz
  mv gzip-1.13 $GZIP_SRC
fi

if [ ! -d $GZIP_SRC/build ]
then
  mkdir -p $GZIP_SRC/build
  cd $GZIP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GZIP_SRC/build
make DESTDIR=$ISO_SYSROOT install



if [ ! -d $MAKE_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
  tar -xf make-4.4.1.tar.gz
  mv make-4.4.1 $MAKE_SRC
fi

if [ ! -d $MAKE_SRC/build_dir ]
then
  mkdir -p $MAKE_SRC/build_dir
  cd $MAKE_SRC/build_dir
  ../configure --prefix=/usr --without-guile --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $MAKE_SRC/build_dir
make DESTDIR=$ISO_SYSROOT install



if [ ! -d $PATCH_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz
  tar -xf patch-2.7.6.tar.xz
  mv patch-2.7.6 $PATCH_SRC
fi

if [ ! -d $PATCH_SRC/build ]
then
  mkdir -p $PATCH_SRC/build
  cd $PATCH_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $PATCH_SRC/build
make DESTDIR=$ISO_SYSROOT install



if [ ! -d $SED_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
  tar -xf sed-4.9.tar.xz
  mv sed-4.9 $SED_SRC
fi


if [ ! -d $SED_SRC/build ]
then
  mkdir -p $SED_SRC/build
  cd $SED_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $SED_SRC/build
make DESTDIR=$ISO_SYSROOT install



if [ ! -d $TAR_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz
  tar -xf tar-1.35.tar.xz
  mv tar-1.35 $TAR_SRC
fi

if [ ! -d $TAR_SRC/build ]
then
  mkdir -p $TAR_SRC/build
  cd $TAR_SRC/build
  ../configure --build=$(../build-aux/config.guess) --host=$TARGET --prefix=/usr
  make -j$(nproc)
fi
cd $TAR_SRC/build
make DESTDIR=$ISO_SYSROOT install



if [ ! -d $XZ_SRC ]
then
  cd $CACHE
  wget https://github.com/tukaani-project/xz/releases/download/v5.6.4/xz-5.6.4.tar.xz
  tar -xf xz-5.6.4.tar.xz
  mv xz-5.6.4 $XZ_SRC
fi

if [ ! -d $XZ_SRC/build ]
then
  mkdir -p $XZ_SRC/build
  cd $XZ_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-static
  make -j$(nproc)
fi
cd $XZ_SRC/build
make DESTDIR=$ISO_SYSROOT install

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
                --enable-shared \
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

