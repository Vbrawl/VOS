#!/bin/bash

export PATH=$CROSS_COMPILER/bin:$PATH

for f in $(ls $ROOT/builder/utils)
do
  $LOGRUN $ROOT/builder/utils/$f &
done
wait
