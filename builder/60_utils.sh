#!/bin/bash

export PATH=$CROSS_COMPILER/bin:$PATH

for f in $ROOT/builder/utils/*.sh
do
  $LOGRUN $f &
done
wait
