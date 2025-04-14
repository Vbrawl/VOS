#!/bin/bash

CURL_SRC=$CACHE/curl
CURL_RPM_NAME=Curl
CURL_VERSION="8.12.1"
CURL_FULLNAME=$CURL_RPM_NAME-$CURL_VERSION
$ROOT/download_and_untar.sh "https://github.com/curl/curl/releases/download/curl-8_12_1/curl-8.12.1.tar.xz" "$CURL_SRC"

if [ ! -d $CURL_SRC/build ]
then
  mkdir -p $CURL_SRC/build
  cd $CURL_SRC/build
  ../configure --prefix=/usr \
                --build=$(../config.guess) \
                --host=$TARGET \
                --with-ca-bundle=/usr/ssl/bundle.crt \
                --with-ca-path=/usr/ssl/certs \
                --disable-debug \
                --enable-warnings \
                --disable-curldebug \
                --enable-optimize \
                --enable-http \
                --enable-ftp \
                --enable-file \
                --enable-ipfs \
                --enable-rtsp \
                --enable-proxy \
                --enable-dict \
                --enable-telnet \
                --enable-tftp \
                --enable-pop3 \
                --enable-imap \
                --enable-smb \
                --enable-smtp \
                --enable-gopher \
                --enable-mqtt \
                --disable-manual \
                --disable-docs \
                --enable-libgcc \
                --enable-ipv6 \
                --enable-versioned-symbols \
                --enable-windows-unicode \
                --enable-sspi \
                --enable-ntlm \
                --enable-unix-sockets \
                --enable-cookies \
                --enable-progress-meter \
                --enable-websockets \
                --with-openssl \
                --without-libpsl
  make -j$(nproc)
fi
cd $CURL_SRC/build
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $CURL_SRC/build/$CURL_FULLNAME.tar $CURL_FULLNAME \
                      usr/bin/{curl,curl-config} \
                      usr/include/{curl/system.h,curl/urlapi.h,curl/header.h,curl/websockets.h,curl/curlver.h,curl/options.h,curl/typecheck-gcc.h,curl/multi.h,curl/easy.h,curl/curl.h,curl/mprintf.h,curl/stdcheaders.h} \
                      usr/lib/{libcurl.a,libcurl.so,libcurl.so.4.8.0,pkgconfig/libcurl.pc,libcurl.so.4,libcurl.la}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$CURL_SRC/build/rpmbuild" \
                      "$CURL_RPM_NAME" \
                      "$CURL_VERSION" \
                      "Curl utilities and libraries" \
                      "curl is a command-line tool for transferring data specified with URL syntax. libcurl is the library curl is using to do its job." \
                      "custom" \
                      "$CURL_SRC/build/$CURL_FULLNAME.tar" \
"usr/bin/curl" "%{_bindir}/curl" \
"usr/bin/curl-config" "%{_bindir}/curl-config" \
"usr/include/curl/system.h" "%{_includedir}/curl/system.h" \
"usr/include/curl/urlapi.h" "%{_includedir}/curl/urlapi.h" \
"usr/include/curl/header.h" "%{_includedir}/curl/header.h" \
"usr/include/curl/websockets.h" "%{_includedir}/curl/websockets.h" \
"usr/include/curl/curlver.h" "%{_includedir}/curl/curlver.h" \
"usr/include/curl/options.h" "%{_includedir}/curl/options.h" \
"usr/include/curl/typecheck-gcc.h" "%{_includedir}/curl/typecheck-gcc.h" \
"usr/include/curl/multi.h" "%{_includedir}/curl/multi.h" \
"usr/include/curl/easy.h" "%{_includedir}/curl/easy.h" \
"usr/include/curl/curl.h" "%{_includedir}/curl/curl.h" \
"usr/include/curl/mprintf.h" "%{_includedir}/curl/mprintf.h" \
"usr/include/curl/stdcheaders.h" "%{_includedir}/curl/stdcheaders.h" \
"usr/lib/libcurl.a" "%{_libdir}/libcurl.a" \
"usr/lib/libcurl.so" "%{_libdir}/libcurl.so" \
"usr/lib/libcurl.so.4.8.0" "%{_libdir}/libcurl.so.4.8.0" \
"usr/lib/pkgconfig/libcurl.pc" "%{_libdir}/pkgconfig/libcurl.pc" \
"usr/lib/libcurl.so.4" "%{_libdir}/libcurl.so.4"
