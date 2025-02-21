#!/bin/bash

cd $BUILD

{ echo init; find usr; find installer; } | cpio -o --format=newc > initrd
