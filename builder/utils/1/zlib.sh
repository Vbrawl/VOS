#!/bin/bash

ZLIB_SRC=$CACHE/zlib
ZLIB_RPM_NAME=ZLib
ZLIB_VERSION="1.3.1"
ZLIB_FULLNAME=$ZLIB_RPM_NAME-$ZLIB_VERSION
$ROOT/download_and_untar.sh "https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.xz" "$ZLIB_SRC"

if [ ! -d $ZLIB_SRC/build ]
then
  mkdir -p $ZLIB_SRC/build
  cd $ZLIB_SRC/build
  CHOST=$TARGET ../configure --prefix=/usr --64
  make -j$(nproc)
fi
cd $ZLIB_SRC/build
make DESTDIR=$ISO_SYSROOT install


$ROOT/generate_tar.sh make $ZLIB_SRC/build/$ZLIB_FULLNAME.tar $ZLIB_FULLNAME \
                      usr/lib/{libz.a,libz.so.1.3.1,libz.so,libz.so.1,pkgconfig/zlib.pc} \
                      usr/include/{zlib.h,zconf.h}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$ZLIB_SRC/build/rpmbuild" \
                      "$ZLIB_RPM_NAME" \
                      "$ZLIB_VERSION" \
                      "ZLib libraries" \
                      "zlib is a general purpose data compression library. All the code is thread safe. The data format used by the zlib library is described by RFCs (Request for Comments) 1950 to 1952 in the files http://tools.ietf.org/html/rfc1950 (zlib format), rfc1951 (deflate format) and rfc1952 (gzip format)." \
                      "custom" \
                      "$ZLIB_SRC/build/$ZLIB_FULLNAME.tar" \
                      "usr/include/zlib.h" "%{_includedir}/zlib.h" \
                      "usr/include/zconf.h" "%{_includedir}/zconf.h" \
                      "usr/lib/libz.a" "%{_libdir}/libz.a" \
                      "usr/lib/libz.so.1.3.1" "%{_libdir}/libz.so.1.3.1" \
                      "usr/lib/libz.so" "%{_libdir}/libz.so" \
                      "usr/lib/libz.so.1" "%{_libdir}/libz.so.1" \
                      "usr/lib/pkgconfig/zlib.pc" "%{_libdir}/pkgconfig/zlib.pc"
