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
  CC=$CROSS_CC ./configure
  make -j$(nproc) || true
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
  CC=$CROSS_CC CFLAGS="-Wno-implicit-function-declaration" ./configure --without-bash-malloc
  make -j$(nproc)
fi

mkdir -p $ISO_SYSROOT/bin
cp $BASH_SRC/bash $ISO_SYSROOT/bin/bash

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
  CC=$CROSS_CC ../configure --prefix=/usr
  make -j$(nproc)
fi
cd $M4_SRC/build
make DESTDIR=$ISO_SYSROOT install


if [ ! -d $NCURSES_SRC ]
then
  cd $CACHE
  wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz
  tar -xf ncurses-6.5.tar.gz
  CC=$CROSS_CC ../configure
  make -j$(nproc)
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
  CC=$CROSS_CC ../configure --prefix=/usr \
                            --with-shared \
                            --without-debug \
                            --without-normal \
                            --with-cxx-shared \
                            --without-ada \
                            --disable-stripping
  make -j$(nproc)
fi

cd $NCURSES_SRC/buildw
make DESTDIR=$ISO_SYSROOT TIC_PATH=$NCURSES_SRC/build-tic/progs/tic install

if [ ! -d $NCURSES_SRC/build ]
then
  mkdir -p $NCURSES_SRC/build
  cd $NCURSES_SRC/build
  CC=$CROSS_CC ../configure --prefix=/usr \
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
# Skip running TIC
make DESTDIR=$ISO_SYSROOT TIC_PATH=$(which true) install



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
  CC=$CROSS_CC ../configure --prefix=/usr
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
  CC=$CROSS_CC ../configure --prefix=/usr
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
  CC=$CROSS_CC ../configure --prefix=/usr
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
  CC=$CROSS_CC ../configure --prefix=/usr
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
  CC=$CROSS_CC ../configure --prefix=/usr
  make -j$(nproc)
fi
cd $GZIP_SRC/build
make DESTDIR=$ISO_SYSROOT install
