#!/bin/bash

LIBMAGIC_SRC=$CACHE/libmagic
LIBMAGIC_RPM_NAME=File
LIBMAGIC_VERSION="5.44"
LIBMAGIC_FULLNAME=$LIBMAGIC_RPM_NAME-$LIBMAGIC_VERSION
$ROOT/download_and_untar.sh "https://astron.com/pub/file/file-5.44.tar.gz" "$LIBMAGIC_SRC"


if [ ! -d $LIBMAGIC_SRC/build ]
then
  mkdir -p $LIBMAGIC_SRC/build
  cd $LIBMAGIC_SRC/build
  ../configure --prefix=/usr --build=$(../config.guess) --host=$TARGET
  make -j$(nproc)
fi

# Make TAR ball
cd $LIBMAGIC_SRC/build
$ROOT/generate_tar.sh make $LIBMAGIC_SRC/build/$LIBMAGIC_FULLNAME.tar $LIBMAGIC_FULLNAME \
      usr/bin/file \
      usr/include/magic.h \
      usr/lib/{libmagic.la,libmagic.so,libmagic.so.1,libmagic.so.1.0.0,pkgconfig/libmagic.pc}

# Make RPM package
cd $LIBMAGIC_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$LIBMAGIC_SRC/build/rpmbuild" \
                      "$LIBMAGIC_RPM_NAME" \
                      "$LIBMAGIC_VERSION" \
                      "File type identification utility" \
                      "The file command is \"a file type guesser\", that is, a command-line tool that tells you in words what kind of data a file contains. Unlike most GUI systems, command-line UNIX systems - with this program leading the charge - don't rely on filename extentions to tell you the type of a file, but look at the file's actual contents. This is, of course, more reliable, but requires a bit of I/O." \
                      "custom" \
                      "$LIBMAGIC_SRC/build/$LIBMAGIC_FULLNAME.tar" \
                      "usr/bin/file" "%{_bindir}/file" \
                      "usr/include/magic.h" "%{_includedir}/magic.h" \
                      "usr/lib/libmagic.la" "%{_libdir}/libmagic.la" \
                      "usr/lib/libmagic.so" "%{_libdir}/libmagic.so" \
                      "usr/lib/libmagic.so.1" "%{_libdir}/libmagic.so.1" \
                      "usr/lib/libmagic.so.1.0.0" "%{_libdir}/libmagic.so.1.0.0" \
                      "usr/lib/pkgconfig/libmagic.pc" "%{_libdir}/pkgconfig/libmagic.pc"
