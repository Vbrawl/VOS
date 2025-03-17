#!/bin/bash

CURL_SRC=$CACHE/curl

download_and_untar "https://github.com/curl/curl/releases/download/curl-8_12_1/curl-8.12.1.tar.xz" "$CURL_SRC"

if [ ! -d $CURL_SRC/build ]
then
  mkdir -p $CURL_SRC/build
  cd $CURL_SRC/build
  ../configure --prefix=/usr \
                --build=$(../config.guess) \
                --host=$TARGET \
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
make DESTDIR=$ISO_SYSROOT install
