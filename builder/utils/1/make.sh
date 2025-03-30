#!/bin/bash

MAKE_SRC=$CACHE/make
MAKE_RPM_NAME=Make
MAKE_VERSION="4.4.1"
MAKE_FULLNAME=$MAKE_RPM_NAME-$MAKE_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz" "$MAKE_SRC"

if [ ! -d $MAKE_SRC/build_dir ]
then
  mkdir -p $MAKE_SRC/build_dir
  cd $MAKE_SRC/build_dir
  ../configure --prefix=/usr --without-guile --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $MAKE_SRC/build_dir
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $MAKE_SRC/build_dir/$MAKE_FULLNAME.tar $MAKE_FULLNAME \
                      usr/bin/make \
                      usr/include/gnumake.h

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$MAKE_SRC/build_dir/rpmbuild" \
                      "$MAKE_RPM_NAME" \
                      "$MAKE_VERSION" \
                      "Make utility" \
                      "GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files." \
                      "GPL-3" \
                      "$MAKE_SRC/build/$MAKE_FULLNAME.tar" \
                      "usr/bin/make" "%{_bindir}/make" \
                      "usr/include/gnumake.h" "%{_includedir}/gnumake.h"
