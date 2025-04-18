#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -f $CROSS_COMPILER_FINISHED ]
then

$ROOT/download_and_untar.sh "https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz" "$COMPILER_SRC"

if [ ! -d $COMPILER_SRC/build-full ]
then
  mkdir -p $COMPILER_SRC/build-full
  cd $COMPILER_SRC/build-full
  ../configure --target=$TARGET \
              --prefix=$CROSS_COMPILER \
              --with-glibc-version=2.41 \
              --with-sysroot=$CACHE_SYSROOT \
              --disable-multilib \
              --disable-nls \
              --enable-languages=c,c++
  make -j$(nproc)
fi
cd $COMPILER_SRC/build-full
make -j$(nproc) install

cat > $MESON_CROSS_FILE << EOF
[binaries]
c = '${TARGET}-gcc'
cpp = '${TARGET}-g++'
ar = '${TARGET}-ar'
windres = '${TARGET}-windres'
strip = '${TARGET}-strip'
pkgconfig = '$(which pkg-config)'

[host_machine]
system = 'linux'
kernel = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = '${ENDIAN}'

[properties]
needs_exe_wrapper = true # Don't try to run resulting binaries on build machine
pkg_config_libdir = '${ISO_SYSROOT}/usr/lib/pkgconfig'
sys_root = '${ISO_SYSROOT}'
EOF

cat > $CMAKE_CROSS_FILE << EOF
set(CMAKE_SYSTEM_NAME ${OS})

set(CMAKE_C_COMPILER  ${TARGET}-gcc)
set(CMAKE_CXX_COMPILER ${TARGET}-g++)

set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)

set(CMAKE_SYSROOT ${ISO_SYSROOT})
set(CMAKE_FIND_ROOT_PATH ${ISO_SYSROOT})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
EOF

touch $CROSS_COMPILER_FINISHED
ln -s $TARGET-gcc $CROSS_COMPILER/bin/$TARGET-cc

fi
