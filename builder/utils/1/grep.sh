#!/bin/bash

GREP_SRC=$CACHE/grep
GREP_RPM_NAME=Grep
GREP_VERSION="3.11"
GREP_FULLNAME=$GREP_RPM_NAME-$GREP_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz" "$GREP_SRC"

if [ ! -d $GREP_SRC/build ]
then
  mkdir -p $GREP_SRC/build
  cd $GREP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

# Build TAR ball ($GREP_SRC/build/$GREP_FULLNAME.tar)
cd $GREP_SRC/build
$ROOT/generate_tar.sh make $GREP_SRC/build/$GREP_FULLNAME.tar $GREP_FULLNAME usr/bin/grep

# Build RPM
cd $GREP_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$GREP_SRC/build/rpmbuild" \
                      "$GREP_RPM_NAME" \
                      "$GREP_VERSION" \
                      "Grep terminal utility/program" \
                      "Grep searches one or more input files for lines containing a match to a specified pattern." \
                      "GPL" \
                      "$GREP_SRC/build/$GREP_FULLNAME.tar" \
                      "usr/bin/grep" "%{_bindir}/grep"
