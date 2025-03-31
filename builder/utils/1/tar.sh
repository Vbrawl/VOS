#!/bin/bash

TAR_SRC=$CACHE/tar
TAR_RPM_NAME=Tar
TAR_VERSION="1.35"
TAR_FULLNAME=$TAR_RPM_NAME-$TAR_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz" "$TAR_SRC"

if [ ! -d $TAR_SRC/build ]
then
  mkdir -p $TAR_SRC/build
  cd $TAR_SRC/build
  ../configure --build=$(../build-aux/config.guess) --host=$TARGET --prefix=/usr
  make -j$(nproc)
fi
cd $TAR_SRC/build
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $TAR_SRC/build/$TAR_FULLNAME.tar $TAR_FULLNAME \
                      usr/libexec/rmt usr/bin/tar

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$TAR_SRC/build/rpmbuild" \
                      "$TAR_RPM_NAME" \
                      "$TAR_VERSION" \
                      "Tar Utility/Library" \
                      "GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation. For example, you can use Tar on previously created archives to extract files, to store additional files, or to update or list files which were already stored." \
                      "GPL-3.0" \
                      "$TAR_SRC/build/$TAR_FULLNAME.tar" \
                      "usr/libexec/rmt" "%{_libexecdir}/rmt" \
                      "usr/bin/tar" "%{_bindir}/tar"
