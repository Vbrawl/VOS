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
  rm -r $SRC_DIR
fi

if [ -f $DST_TAR ]
then
  rm $DST_TAR
fi

export DESTDIR=$(pwd)/$SRC_DIR
if [ $INSTALL_METHOD == "make" ]
then
  make install
elif [ $INSTALL_METHOD == "cmake" ]
then
  cmake --install .
elif [ $INSTALL_METHOD == "meson" ]
then
  meson install
fi

tar -cf $DST_TAR -R ${FILES[@]}
