#!/bin/bash

CWD=$1
PREFIX=$2

OUTPUT="$PREFIX/{"
cd $CWD
for i in $(find $PREFIX ! -type d)
do
  OUTPUT+=${i#"$PREFIX/"}
  OUTPUT+=","
done

OUTPUT+="}"
echo $OUTPUT
