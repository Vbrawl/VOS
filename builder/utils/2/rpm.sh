#!/bin/bash

RPM_SRC=$CACHE/rpm

$ROOT/download_and_untar.sh "https://github.com/rpm-software-management/rpm/archive/refs/tags/rpm-4.20.1-release.tar.gz" "$RPM_SRC"

if [ ! -d $RPM_SRC/builddir ]
then
  cd $RPM_SRC
  cmake -Bbuilddir \
        -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CROSS_FILE \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DLUA_LIBRARIES=${ISO_SYSROOT}/usr/lib/liblua.so \
        -DLUA_INCLUDE_DIR=${ISO_SYSROOT}/usr/include \
        -DZLIB_LIBRARY=${ISO_SYSROOT}/usr/lib/libz.so \
        -DZLIB_INCLUDE_DIR=${ISO_SYSROOT}/usr/include \
        -DMAGIC_LIBRARY=${ISO_SYSROOT}/usr/lib/libmagic.so \
        -DMAGIC_INCLUDE_DIR=${ISO_SYSROOT}/usr/include \
        -DWITH_OPENSSL=ON \
        -DOPENSSL_CRYPTO_LIBRARY=${ISO_SYSROOT}/usr/lib64/libcrypto.so \
        -DOPENSSL_INCLUDE_DIR=${ISO_SYSROOT}/usr/include/openssl \
        -DWITH_BZIP2=OFF \
        -DWITH_ICONV=OFF \
        -DWITH_READLINE=OFF \
        -DWITH_ZSTD=OFF \
        -DWITH_LIBELF=OFF \
        -DWITH_LIBDW=OFF \
        -DWITH_CAP=OFF \
        -DWITH_ACL=OFF \
        -DWITH_AUDIT=OFF \
        -DWITH_SELINUX=OFF \
        -DWITH_SEQUOIA=OFF \
        -DWITH_DBUS=OFF \
        -DENABLE_SQLITE=OFF \
        -DENABLE_PYTHON=OFF \
        -DENABLE_OPENMP=OFF
  cmake --build builddir
fi
cd $RPM_SRC
DESTDIR=$ISO_SYSROOT cmake --install builddir

for f in usr/bin/{rpm,rpm2archive,rpm2cpio,rpmbuild,rpmdb,rpmgraph,rpmkeys,rpmlua,rpmquery,rpmsign,rpmsort,rpmspec,rpmverify} \
          usr/lib/{librpmbuild.so,librpmio.so,librpmsign.so,librpm.so} \
          usr/lib/rpm/{rpmuncompress,rpmdump,rpmdeps} \
          usr/lib/rpm-plugins/{fapolicyd.so,prioreset.so,syslog.so,unshare.so}
do
#  echo $ISO_SYSROOT/$f
  patchelf $ISO_SYSROOT/$f --replace-needed ../lib/librpm.so librpm.so
  patchelf $ISO_SYSROOT/$f --replace-needed ../rpmio/librpmio.so librpmio.so
done

patchelf $ISO_SYSROOT/usr/lib/librpmio.so --replace-needed ${ISO_SYSROOT}/usr/lib/libzlib.so libzlib.so
