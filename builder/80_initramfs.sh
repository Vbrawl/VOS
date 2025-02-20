#!/bin/bash

cd $BUILD

{ echo init; find usr; } | cpio -o --format=newc > initrd
