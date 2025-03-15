#!/bin/bash

export PATH=$CROSS_COMPILER/bin:$PATH

for phase in $ROOT/builder/utils/*
do
  for f in $phase/*.sh
  do
    $LOGRUN $f &
  done
  wait
done
