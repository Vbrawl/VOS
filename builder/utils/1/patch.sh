#!/bin/bash

PATCH_SRC=$CACHE/patch
PATCH_RPM_NAME=Patch
PATCH_VERSION="2.7.6"
PATCH_FULLNAME=$PATCH_RPM_NAME-$PATCH_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz" "$PATCH_SRC"

if [ ! -d $PATCH_SRC/build ]
then
  mkdir -p $PATCH_SRC/build
  cd $PATCH_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $PATCH_SRC/build
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $PATCH_SRC/build/$PATCH_FULLNAME.tar $PATCH_FULLNAME \
                      usr/bin/patch

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$PATCH_SRC/build/rpmbuild" \
                      "$PATCH_RPM_NAME" \
                      "$PATCH_VERSION" \
                      "Patch utility" \
                      "This is GNU patch, which applies diff files to original files." \
                      "GPL-3.0" \
                      "$PATCH_SRC/build/$PATCH_FULLNAME.tar" \
                      "usr/bin/patch" "%{_bindir}/patch"
