#!/bin/bash

SHELL_SRC=$CACHE/bash

if [ ! -d $SHELL_SRC ]
then
  git clone --depth 1 https://git.savannah.gnu.org/git/bash.git $SHELL_SRC
fi

cd $SHELL_SRC

if [ ! -f bash ]
then
  ./configure --enable-static-link
  make -j$(nproc)
fi

cp bash $BUILD_BIN/bash
cp bash $BUILD/init
