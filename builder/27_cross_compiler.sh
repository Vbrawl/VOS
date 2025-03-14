#!/bin/bash

COMPILER_SRC=$CACHE/gcc

if [ ! -f $CROSS_COMPILER_FINISHED ]
then

download_and_untar "https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-14.2.0/gcc-14.2.0.tar.xz" "$COMPILER_SRC"

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

cat > $CROSS_COMPILER/cross_cc.meson << EOF
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

touch $CROSS_COMPILER_FINISHED
ln -s $TARGET-gcc $CROSS_COMPILER/bin/$TARGET-cc

fi

export MESON_CROSS_FILE=$CROSS_COMPILER/cross_cc.meson
export CROSS_CC=$CROSS_COMPILER/bin/$TARGET-gcc
