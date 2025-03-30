#!/bin/bash

set -e

GZIP_SRC=$CACHE/gzip
GZIP_RPM_NAME=Gzip
GZIP_VERSION="1.13"
GZIP_FULLNAME=$GZIP_RPM_NAME-$GZIP_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz" $GZIP_SRC

if [ ! -d $GZIP_SRC/build ]
then
  mkdir -p $GZIP_SRC/build
  cd $GZIP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

# Build TAR ball ($GZIP_SRC/build/${GZIP_RPM_NAME}-${GZIP_VERSION}.tar)
cd $GZIP_SRC/build
$ROOT/generate_tar.sh make $GZIP_SRC/build/$GZIP_FULLNAME.tar $GZIP_FULLNAME usr/bin/{gunzip,gzip,zcat,zdiff,zfgrep,zgrep,zmore,gzexe,uncompress,zcmp,zegrep,zforce,zless,znew}

# Build RPM
cd $GZIP_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$GZIP_SRC/build/rpmbuild" \
                      "$GZIP_RPM_NAME" \
                      "$GZIP_VERSION" \
                      "Gzip terminal utility/program" \
                      "GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project. Mark Adler wrote the decompression part." \
                      "GPL" \
                      "$GZIP_SRC/build/$GZIP_FULLNAME.tar" \
                      "usr/bin/gunzip" "%{_bindir}/gunzip" \
                      "usr/bin/gzip" "%{_bindir}/gzip" \
                      "usr/bin/zcat" "%{_bindir}/zcat" \
                      "usr/bin/zdiff" "%{_bindir}/zdiff" \
                      "usr/bin/zfgrep" "%{_bindir}/zfgrep" \
                      "usr/bin/zgrep" "%{_bindir}/zgrep" \
                      "usr/bin/zmore" "%{_bindir}/zmore" \
                      "usr/bin/gzexe" "%{_bindir}/gzexe" \
                      "usr/bin/uncompress" "%{_bindir}/uncompress" \
                      "usr/bin/zcmp" "%{_bindir}/zcmp" \
                      "usr/bin/zegrep" "%{_bindir}/zegrep" \
                      "usr/bin/zforce" "%{_bindir}/zforce" \
                      "usr/bin/zless" "%{_bindir}/zless" \
                      "usr/bin/znew" "%{_bindir}/znew"
