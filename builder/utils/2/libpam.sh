#!/bin/bash

PAM_SRC=$CACHE/pam
$ROOT/download_and_untar.sh "https://github.com/linux-pam/linux-pam/releases/download/v1.7.0/Linux-PAM-1.7.0.tar.xz" "$PAM_SRC"

if [ ! -d $PAM_SRC/build ]
then
  cd $PAM_SRC
  patch -p1 < $ROOT/patches/pam.patch
  meson setup build --cross-file $MESON_CROSS_FILE -Dc_args="-Wno-implicit-function-declaration -Wno-int-conversion -I${ISO_SYSROOT}/usr/include"
  cd $PAM_SRC/build
  meson compile
fi
cd $PAM_SRC/build
DESTDIR=$ISO_SYSROOT meson install
