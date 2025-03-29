#!/bin/bash

DIFFUTILS_SRC=$CACHE/diffutils
DIFFUTILS_RPM_NAME=DiffUtils
DIFFUTILS_VERSION="3.11"
DIFFUTILS_FULLNAME=$DIFFUTILS_RPM_NAME-$DIFFUTILS_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/diffutils/diffutils-3.11.tar.xz" "$DIFFUTILS_SRC"

if [ ! -d $DIFFUTILS_SRC/build ]
then
  mkdir -p $DIFFUTILS_SRC/build
  cd $DIFFUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

cd $DIFFUTILS_SRC/build
$ROOT/generate_tar.sh make $DIFFUTILS_SRC/build/$DIFFUTILS_FULLNAME.tar $DIFFUTILS_FULLNAME \
                      usr/bin/{cmp,diff,diff3,sdiff}

cd $DIFFUTILS_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$DIFFUTILS_SRC/build/rpmbuild" \
                      "$DIFFUTILS_RPM_NAME" \
                      "$DIFFUTILS_VERSION" \
                      "DiffUtils utilities" \
                      "GNU Diffutils is a package of several programs related to finding differences between files." \
                      "GPL-3" \
                      "$DIFFUTILS_SRC/build/$DIFFUTILS_FULLNAME.tar" \
                      "usr/bin/cmp" "%{_bindir}/cmp" \
                      "usr/bin/diff" "%{_bindir}/diff" \
                      "usr/bin/diff3" "%{_bindir}/diff3" \
                      "usr/bin/sdiff" "%{_bindir}/sdiff"
