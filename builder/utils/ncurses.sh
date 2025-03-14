#!/bin/bash

NCURSES_SRC=$CACHE/ncurses
download_and_untar "https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz" "$NCURSES_SRC"

if [ ! -d $NCURSES_SRC/build-tic ]
then
  mkdir -p $NCURSES_SRC/build-tic
  cd $NCURSES_SRC/build-tic
  ../configure --without-manpages --without-tests --without-debug
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
                --disable-stripping \
                --without-manpages \
                --without-tests
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
                --disable-stripping \
                --without-manpages \
                --without-tests
  make -j $(nproc)
fi

cd $NCURSES_SRC/build
make DESTDIR=$ISO_SYSROOT TIC_PATH=$NCURSES_SRC/build-tic/progs/tic install
cd $NCURSES_SRC/buildw
make DESTDIR=$ISO_SYSROOT TIC_PATH=$NCURSES_SRC/build-tic/progs/tic install
