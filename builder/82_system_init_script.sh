#!/bin/bash

INITUP_SRC=$CACHE/initup

if [ ! -d $INITUP_SRC ]
then
  cd $CACHE
  git clone https://github.com/Vbrawl/initup $INITUP_SRC --depth 1
fi

if [ ! -d $INITUP_SRC/build ]
then
  cd $INITUP_SRC
  meson setup --cross-file $MESON_CROSS_FILE build
  meson compile -C build
fi

cd $INITUP_SRC/build
DESTDIR=$ISO_SYSROOT/usr meson install
