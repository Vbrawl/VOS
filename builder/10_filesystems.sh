#!/bin/bash

INSTALLER_SRC=$ROOT/installer
INSTALLER_DEST=$BUILD_ISO/installer

FS_SRC=$ROOT/fs
FS_DEST=$ISO_SYSROOT

cp -r $INSTALLER_SRC $INSTALLER_DEST

if [ -n "$(ls -A $FS_SRC)" ]
then
  cp -r $FS_SRC/* $FS_DEST
fi
