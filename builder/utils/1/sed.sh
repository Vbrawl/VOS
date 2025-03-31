#!/bin/bash

SED_SRC=$CACHE/sed
SED_RPM_NAME=Sed
SED_VERSION="4.9"
SED_FULLNAME=$SED_RPM_NAME-$SED_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz" "$SED_SRC"

if [ ! -d $SED_SRC/build ]
then
  mkdir -p $SED_SRC/build
  cd $SED_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $SED_SRC/build

$ROOT/generate_tar.sh make $SED_SRC/build/$SED_FULLNAME.tar $SED_FULLNAME \
                      usr/bin/sed

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$SED_SRC/build/rpmbuild" \
                      "$SED_RPM_NAME" \
                      "$SED_VERSION" \
                      "Sed utility" \
                      "sed (stream editor) is a non-interactive command-line text editor." \
                      "GPL-3.0" \
                      "$SED_SRC/build/$SED_FULLNAME.tar" \
                      "usr/bin/sed" "%{_bindir}/sed"
