#!/bin/bash

set -e

LIBARCHIVE_SRC=$CACHE/libarchive
LIBARCHIVE_RPM_NAME=LibArchive
LIBARCHIVE_VERSION="3.7.8"
LIBARCHIVE_FULLNAME=$LIBARCHIVE_RPM_NAME-$LIBARCHIVE_VERSION
$ROOT/download_and_untar.sh "https://github.com/libarchive/libarchive/releases/download/v3.7.8/libarchive-3.7.8.tar.gz" "$LIBARCHIVE_SRC"

if [ ! -d $LIBARCHIVE_SRC/builddir ]
then
  cd $LIBARCHIVE_SRC
  cmake -Bbuilddir -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CROSS_FILE -DCMAKE_INSTALL_PREFIX=/usr
  cmake --build builddir
fi

# Build TAR ball ($LIBARCHIVE_SRC/builddir/$LIBARCHIVE_FULLNAME.tar)
cd $LIBARCHIVE_SRC/builddir
$ROOT/generate_tar.sh cmake $LIBARCHIVE_SRC/builddir/$LIBARCHIVE_FULLNAME.tar $LIBARCHIVE_FULLNAME \
                  usr/bin/{bsdcat,bsdcpio,bsdtar,bsdunzip} \
                  usr/include/{archive_entry,archive}.h \
                  usr/lib/{libarchive.a,libarchive.so,pkgconfig/libarchive.pc}

# Build RPM
cd $LIBARCHIVE_SRC/builddir
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$LIBARCHIVE_SRC/builddir/rpmbuild" \
                      "$LIBARCHIVE_RPM_NAME" \
                      "$LIBARCHIVE_VERSION" \
                      "Summary" \
                      "Description" \
                      "License" \
                      "$LIBARCHIVE_SRC/builddir/$LIBARCHIVE_FULLNAME.tar" \
                      "usr/bin/bsdcat" "%{_bindir}/bsdcat" \
                      "usr/bin/bsdcpio" "%{_bindir}/bsdcpio" \
                      "usr/bin/bsdtar" "%{_bindir}/bsdtar" \
                      "usr/bin/bsdunzip" "%{_bindir}/bsdunzip" \
                      "usr/include/archive_entry.h" "%{_includedir}/archive_entry.h" \
                      "usr/include/archive.h" "%{_includedir}/archive.h" \
                      "usr/lib/libarchive.a" "%{_libdir}/libarchive.a" \
                      "usr/lib/libarchive.so" "%{_libdir}/libarchive.so" \
                      "usr/lib/pkgconfig/libarchive.pc" "%{_libdir}/pkgconfig/libarchive.pc"
