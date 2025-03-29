#!/bin/bash

LIBXCRYPT_SRC=$CACHE/libxcrypt
LIBXCRYPT_RPM_NAME=LibXCrypt
LIBXCRYPT_VERSION="4.4.38"
LIBXCRYPT_FULLNAME=$LIBXCRYPT_RPM_NAME-$LIBXCRYPT_VERSION
$ROOT/download_and_untar.sh "https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz" "$LIBXCRYPT_SRC"

if [ ! -d $LIBXCRYPT_SRC/build ]
then
  mkdir -p $LIBXCRYPT_SRC/build
  cd $LIBXCRYPT_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/m4-autogen/config.guess) --host=$TARGET --enable-year2038
  make -j$(nproc)
fi
cd $LIBXCRYPT_SRC/build
make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $LIBXCRYPT_SRC/build/$LIBXCRYPT_FULLNAME.tar $LIBXCRYPT_FULLNAME \
                      usr/include/{xcrypt,crypt}.h \
                      usr/lib/{libcrypt.a,libcrypt.so,libcrypt.so.1,libcrypt.so.1.1.0,libowcrypt.a,libowcrypt.so,libowcrypt.so.1,libxcrypt.a,libxcrypt.so} \
                      usr/lib/pkgconfig/lib{crypt,xcrypt}.pc

cd $LIBXCRYPT_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$LIBXCRYPT_SRC/build/rpmbuild" \
                      "$LIBXCRYPT_RPM_NAME" \
                      "$LIBXCRYPT_VERSION" \
                      "LibXCrypt library" \
                      "libxcrypt is a modern library for one-way hashing of passwords. It supports a wide variety of both modern and historical hashing methods: yescrypt, gost-yescrypt, sm3-yescrypt, scrypt, bcrypt, sha512crypt, sha256crypt, sm3crypt, md5crypt, SunMD5, sha1crypt, NT, bsdicrypt, bigcrypt, and descrypt. It provides the traditional Unix crypt and crypt_r interfaces, as well as a set of extended interfaces pioneered by Openwall Linux, crypt_rn, crypt_ra, crypt_gensalt, crypt_gensalt_rn, and crypt_gensalt_ra." \
                      "LGPL-2.1" \
                      "$LIBXCRYPT_SRC/build/$LIBXCRYPT_FULLNAME.tar" \
                      "usr/include/xcrypt.h" "%{_includedir}/xcrypt.h" \
                      "usr/include/crypt.h" "%{_includedir}/crypt.h" \
                      "usr/lib/libcrypt.so" "%{_libdir}/libcrypt.so" \
                      "usr/lib/libxcrypt.so" "%{_libdir}/libxcrypt.so" \
                      "usr/lib/libcrypt.so.1" "%{_libdir}/libcrypt.so.1" \
                      "usr/lib/libcrypt.a" "%{_libdir}/libcrypt.a" \
                      "usr/lib/libxcrypt.a" "%{_libdir}/libxcrypt.a" \
                      "usr/lib/libowcrypt.a" "%{_libdir}/libowcrypt.a" \
                      "usr/lib/libowcrypt.so.1" "%{_libdir}/libowcrypt.so.1" \
                      "usr/lib/libcrypt.so.1.1.0" "%{_libdir}/libcrypt.so.1.1.0" \
                      "usr/lib/pkgconfig/libcrypt.pc" "%{_libdir}/pkgconfig/libcrypt.pc" \
                      "usr/lib/pkgconfig/libxcrypt.pc" "%{_libdir}/pkgconfig/libxcrypt.pc" \
                      "usr/lib/libowcrypt.so" "%{_libdir}/libowcrypt.so"
