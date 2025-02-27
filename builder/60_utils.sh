#!/bin/bash

CORE_SRC=$CACHE/coreutils
BASH_SRC=$CACHE/bash
M4_SRC=$CACHE/m4
NCURSES_SRC=$CACHE/ncurses

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
