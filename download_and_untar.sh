#!/bin/bash

URL=$1
SRC=$2
extension=$(echo $URL | rev | cut -d '.' -f 1 | rev)
if [ -n "$extension" ]
then
  extension=".$extension"
fi

if [ ! -d $SRC ]
then
  cd $CACHE
  wget -c $URL -O $SRC.tar$extension
  mkdir -p $SRC
  tar -xf $SRC.tar$extension -C $SRC --strip-components=1
fi
