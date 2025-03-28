#!/bin/bash

FINDUTILS_SRC=$CACHE/findutils
FINDUTILS_RPM_NAME=FindUtils
FINDUTILS_VERSION="4.10.0"
FINDUTILS_FULLNAME=${FINDUTILS_RPM_NAME}-${FINDUTILS_VERSION}
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz" "$FINDUTILS_SRC"

if [ ! -d $FINDUTILS_SRC/build ]
then
  mkdir -p $FINDUTILS_SRC/build
  cd $FINDUTILS_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $FINDUTILS_SRC/build
#make DESTDIR=$ISO_SYSROOT install
$ROOT/generate_tar.sh make $FINDUTILS_SRC/build/$FINDUTILS_FULLNAME.tar $FINDUTILS_FULLNAME \
                      usr/bin/{find,locate,updatedb,xargs} \
                      usr/libexec/frcode

cd $FINDUTILS_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$FINDUTILS_SRC/build/rpmbuild" \
                      "$FINDUTILS_RPM_NAME" \
                      "$FINDUTILS_VERSION" \
                      "Summary" \
                      "Description" \
                      "License" \
                      "$FINDUTILS_SRC/build/$FINDUTILS_FULLNAME.tar" \
                      "usr/bin/find" "%{_bindir}/find" \
                      "usr/bin/locate" "%{_bindir}/locate" \
                      "usr/bin/updatedb" "%{_bindir}/updatedb" \
                      "usr/bin/xargs" "%{_bindir}/xargs" \
                      "usr/libexec/frcode" "%{_libexecdir}/frcode"
