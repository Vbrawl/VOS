#!/bin/bash

CWD=$1
LIST_DIR=$2
SET_DEST=$3

cd $CWD
SRCFILES=$(find $LIST_DIR ! -type d)
DSTFILES=$(echo $SRCFILES | sed "s|$LIST_DIR|$SET_DEST|g")

read -r -d '\n' -a SRCARR <<< "$SRCFILES"
read -r -d '\n' -a DSTARR <<< "$DSTFILES"

for i in ${!SRCARR[@]}
do
  echo "\"${SRCARR[$i]}\" \"${DSTARR[$i]}\" \\"
done
