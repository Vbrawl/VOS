#!/bin/bash

set -e

source environment.sh

# Add files that most likely don't exist
if [ ! -f fs/etc/protocols ]
then
  ./update-protocols.sh
fi

# Clean build directory
if [ -d $BUILD ]
then
  rm -rf $BUILD
fi

if [ -d $LOGS ]
then
  rm -rf $LOGS
fi

# Create all directories
mkdir -p $CACHE
mkdir -p $CROSS_COMPILER
mkdir -p $BUILD
mkdir -p $BUILD_INITRD
mkdir -p $BUILD_ISO
mkdir -p $CACHE_SYSROOT
mkdir -p $ISO_SYSROOT
mkdir -p $DIST
mkdir -p $LOGS

# Execute all scripts
for s in $BUILDER_SRC/*.sh
do
  source $s
done

cd $ROOT
./generate_iso.sh
