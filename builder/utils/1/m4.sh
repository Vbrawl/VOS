#!/bin/bash

M4_SRC=$CACHE/m4
M4_RPM_NAME=M4
M4_VERSION="1.4.19"
M4_FULLNAME=$M4_RPM_NAME-$M4_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz" "$M4_SRC"

if [ ! -d $M4_SRC/build ]
then
  mkdir -p $M4_SRC/build
  cd $M4_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $M4_SRC/build
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $M4_SRC/build/$M4_FULLNAME.tar $M4_FULLNAME \
                      usr/bin/m4
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$M4_SRC/build/rpmbuild" \
                      "$M4_RPM_NAME" \
                      "$M4_VERSION" \
                      "M4 utility" \
                      "GNU M4 is an implementation of the traditional Unix macro processor. It is mostly SVR4 compatible although it has some extensions (for example, handling more than 9 positional parameters to macros). GNU M4 also has built-in functions for including files, running shell commands, doing arithmetic, etc." \
                      "GPL-3" \
                      "$M4_SRC/build/$M4_FULLNAME.tar" \
                      "usr/bin/m4" "%{_bindir}/m4"
