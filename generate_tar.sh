#!/bin/bash

# INSTALL_METHOD: make, cmake, meson
INSTALL_METHOD=$1
DST_TAR=$2
SRC_DIR=$3
shift 3

FILES=()
for f in "$@"
do
  FILES+=("${SRC_DIR}/${f}")
done

if [ -d $SRC_DIR ]
then
  rm -rf $SRC_DIR
fi

if [ -f $DST_TAR ]
then
  rm -f $DST_TAR
fi

if [ $INSTALL_METHOD == "make" ]
then
  make DESTDIR=$(pwd)/$SRC_DIR install
elif [ $INSTALL_METHOD == "cmake" ]
then
  DESTDIR=$(pwd)/$SRC_DIR cmake --install .
elif [ $INSTALL_METHOD == "meson" ]
then
  DESTDIR=$(pwd)/$SRC_DIR meson install
fi

tar -cf $DST_TAR -R ${FILES[@]}
