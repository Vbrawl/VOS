#!/bin/bash

cd $BUILD

cpio -o --format=newc > initrd << EOF
init
EOF
