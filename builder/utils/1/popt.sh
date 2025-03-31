#!/bin/bash

POPT_SRC=$CACHE/popt
POPT_RPM_NAME=Popt
POPT_VERSION="1.19"
POPT_FULLNAME=$POPT_RPM_NAME-$POPT_VERSION
$ROOT/download_and_untar.sh "https://github.com/rpm-software-management/popt/archive/refs/tags/popt-1.19-release.tar.gz" "$POPT_SRC"

if [ ! -d $POPT_SRC/build ]
then
  cd $POPT_SRC
  ./autogen.sh

  mkdir -p $POPT_SRC/build
  cd $POPT_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-nls
  make -j$(nproc)
fi
cd $POPT_SRC/build
make DESTDIR=$ISO_SYSROOT install
rm $ISO_SYSROOT/usr/lib/libopt.la

$ROOT/generate_tar.sh make $POPT_SRC/build/$POPT_FULLNAME.tar $POPT_FULLNAME \
                      usr/lib/libpopt.{a,so,so.0.0.2,so.0} \
                      usr/lib/pkgconfig/popt.pc \
                      usr/include/popt.h

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$POPT_SRC/build/rpmbuild" \
                      "$POPT_RPM_NAME" \
                      "$POPT_VERSION" \
                      "Popt libraries" \
                      "The popt library exists essentially for parsing command-line options. It is found superior in many ways when compared to parsing the argv array by hand or using the getopt functions" \
                      "MIT" \
                      "$POPT_SRC/build/$POPT_FULLNAME.tar" \
                      "usr/lib/libpopt.a" "%{_libdir}/libpopt.a" \
                      "usr/lib/libpopt.so" "%{_libdir}/libpopt.so" \
                      "usr/lib/pkgconfig/popt.pc" "%{_libdir}/pkgconfig/popt.pc" \
                      "usr/lib/libpopt.so.0.0.2" "%{_libdir}/libpopt.so.0.0.2" \
                      "usr/lib/libpopt.so.0" "%{_libdir}/libpopt.so.0" \
                      "usr/include/popt.h" "%{_includedir}/popt.h"
