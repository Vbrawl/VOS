#!/bin/bash


cd executables/hello_world

make
mv hello_world $BUILD/init

cd $BUILD

cpio -o --format=newc > initrd << EOF
init
EOF
