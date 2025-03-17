#!/bin/bash

for phase in $ROOT/builder/utils/*
do
  for f in $phase/*.sh
  do
    $LOGRUN $f &
  done
  wait
done
