#!/bin/bash

XZ_SRC=$CACHE/xz
XZ_RPM_NAME=Xz
XZ_VERSION="5.6.4"
XZ_FULLNAME=$XZ_RPM_NAME-$XZ_VERSION
$ROOT/download_and_untar.sh "https://github.com/tukaani-project/xz/releases/download/v5.6.4/xz-5.6.4.tar.xz" "$XZ_SRC"

if [ ! -d $XZ_SRC/build ]
then
  mkdir -p $XZ_SRC/build
  cd $XZ_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-static
  make -j$(nproc)
fi
cd $XZ_SRC/build
make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $XZ_SRC/build/$XZ_FULLNAME.tar $XZ_FULLNAME \
                      usr/lib/{liblzma.so.5.6.4,liblzma.so,liblzma.so.5} \
                      usr/lib/pkgconfig/liblzma.pc \
                      usr/include/lzma.h \
                      usr/include/lzma/{block,base,version,vli,lzma12}.h \
                      usr/include/lzma/{container,hardware,stream_flags}.h \
                      usr/include/lzma/{bcj,check,index,delta,filter}.h \
                      usr/include/lzma/index_hash.h \
                      usr/bin/{lzgrep,xzless,xzdec,xzegrep,unxz,lzmore} \
                      usr/bin/{xzdiff,lzcat,lzcmp,lzmadec,xzfgrep,xzgrep} \
                      usr/bin/{lzless,lzmainfo,unlzma,lzdiff,xzmore,xz} \
                      usr/bin/{lzegrep,xzcmp,lzma,lzfgrep,xzcat}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$XZ_SRC/build/rpmbuild" \
                      "$XZ_RPM_NAME" \
                      "$XZ_VERSION" \
                      "XZ Utilities/Libraries" \
                      "XZ Utils provide a general-purpose data-compression library plus command-line tools. The native file format is the .xz format, but also the legacy .lzma format is supported. The .xz format supports multiple compression algorithms, which are called "filters" in the context of XZ Utils. The primary filter is currently LZMA2. With typical files, XZ Utils create about 30 % smaller files than gzip." \
                      "GPL-3.0" \
                      "$XZ_SRC/build/$XZ_FULLNAME.tar" \
                      "usr/include/lzma.h" "%{_includedir}/lzma.h" \
                      "usr/include/lzma/block.h" "%{_includedir}/lzma/block.h" \
                      "usr/include/lzma/base.h" "%{_includedir}/lzma/base.h" \
                      "usr/include/lzma/version.h" "%{_includedir}/lzma/version.h" \
                      "usr/include/lzma/vli.h" "%{_includedir}/lzma/vli.h" \
                      "usr/include/lzma/lzma12.h" "%{_includedir}/lzma/lzma12.h" \
                      "usr/include/lzma/container.h" "%{_includedir}/lzma/container.h" \
                      "usr/include/lzma/hardware.h" "%{_includedir}/lzma/hardware.h" \
                      "usr/include/lzma/stream_flags.h" "%{_includedir}/lzma/stream_flags.h" \
                      "usr/include/lzma/bcj.h" "%{_includedir}/lzma/bcj.h" \
                      "usr/include/lzma/check.h" "%{_includedir}/lzma/check.h" \
                      "usr/include/lzma/index.h" "%{_includedir}/lzma/index.h" \
                      "usr/include/lzma/delta.h" "%{_includedir}/lzma/delta.h" \
                      "usr/include/lzma/filter.h" "%{_includedir}/lzma/filter.h" \
                      "usr/include/lzma/index_hash.h" "%{_includedir}/lzma/index_hash.h" \
                      "usr/lib/liblzma.so.5.6.4" "%{_libdir}liblzma.so.5.6.4" \
                      "usr/lib/liblzma.so" "%{_libdir}liblzma.so" \
                      "usr/lib/liblzma.so.5" "%{_libdir}liblzma.so.5" \
                      "usr/lib/pkgconfig/liblzma.pc" "%{_libdir}pkgconfig/liblzma.pc" \
                      "usr/bin/lzgrep" "%{_bindir}/lzgrep" \
                      "usr/bin/xzless" "%{_bindir}/xzless" \
                      "usr/bin/xzdec" "%{_bindir}/xzdec" \
                      "usr/bin/xzegrep" "%{_bindir}/xzegrep" \
                      "usr/bin/unxz" "%{_bindir}/unxz" \
                      "usr/bin/lzmore" "%{_bindir}/lzmore" \
                      "usr/bin/xzdiff" "%{_bindir}/xzdiff" \
                      "usr/bin/lzcat" "%{_bindir}/lzcat" \
                      "usr/bin/lzcmp" "%{_bindir}/lzcmp" \
                      "usr/bin/lzmadec" "%{_bindir}/lzmadec" \
                      "usr/bin/xzfgrep" "%{_bindir}/xzfgrep" \
                      "usr/bin/xzgrep" "%{_bindir}/xzgrep" \
                      "usr/bin/lzless" "%{_bindir}/lzless" \
                      "usr/bin/lzmainfo" "%{_bindir}/lzmainfo" \
                      "usr/bin/unlzma" "%{_bindir}/unlzma" \
                      "usr/bin/lzdiff" "%{_bindir}/lzdiff" \
                      "usr/bin/xzmore" "%{_bindir}/xzmore" \
                      "usr/bin/xz" "%{_bindir}/xz" \
                      "usr/bin/lzegrep" "%{_bindir}/lzegrep" \
                      "usr/bin/xzcmp" "%{_bindir}/xzcmp" \
                      "usr/bin/lzma" "%{_bindir}/lzma" \
                      "usr/bin/lzfgrep" "%{_bindir}/lzfgrep" \
                      "usr/bin/xzcat" "%{_bindir}/xzcat"
