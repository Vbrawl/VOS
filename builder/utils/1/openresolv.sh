#!/bin/bash

OPENRESOLV_SRC=$CACHE/openresolv
OPENRESOLV_RPM_NAME=OpenResolv
OPENRESOLV_VERSION="3.13.2"
OPENRESOLV_FULLNAME=$OPENRESOLV_RPM_NAME-$OPENRESOLV_VERSION
$ROOT/download_and_untar.sh "https://github.com/NetworkConfiguration/openresolv/archive/refs/tags/v3.13.2.tar.gz" "$OPENRESOLV_SRC"
cd $OPENRESOLV_SRC

if [ ! -f $OPENRESOLV_SRC/resolvconf ]
then
  ./configure --prefix=/usr --sysconfdir=/etc --target=$TARGET --host=$TARGET
  make -j$(nproc)
fi

#make DESTDIR=$ISO_SYSROOT install
$ROOT/generate_tar.sh make $OPENRESOLV_SRC/$OPENRESOLV_FULLNAME.tar $OPENRESOLV_FULLNAME \
                      etc/resolvconf.conf \
                      usr/lib/resolvconf/{dnsmasq,libc,named,pdnsd,pdns_recursor,unbound} \
                      usr/lib/resolvconf/libc.d/{avahi-daemon,mdnsd} \
                      usr/sbin/resolvconf

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$OPENRESOLV_SRC/rpmbuild" \
                      "$OPENRESOLV_RPM_NAME" \
                      "$OPENRESOLV_VERSION" \
                      "OpenResolv utilities/libraries" \
                      "openresolv is a resolvconf implementation which manages /etc/resolv.conf." \
                      "BSD-2-Clause" \
                      "$OPENRESOLV_SRC/$OPENRESOLV_FULLNAME.tar" \
                      "etc/resolvconf.conf" "%{_sysconfdir}/resolvconf.conf" \
                      "usr/lib/resolvconf/libc" "%{_libdir}/resolvconf/libc" \
                      "usr/lib/resolvconf/dnsmasq" "%{_libdir}/resolvconf/dnsmasq" \
                      "usr/lib/resolvconf/pdnsd" "%{_libdir}/resolvconf/pdnsd" \
                      "usr/lib/resolvconf/unbound" "%{_libdir}/resolvconf/unbound" \
                      "usr/lib/resolvconf/libc.d/avahi-daemon" "%{_libdir}/resolvconf/libc.d/avahi-daemon" \
                      "usr/lib/resolvconf/libc.d/mdnsd" "%{_libdir}/resolvconf/libc.d/mdnsd" \
                      "usr/lib/resolvconf/pdns_recursor" "%{_libdir}/resolvconf/pdns_recursor" \
                      "usr/lib/resolvconf/named" "%{_libdir}/resolvconf/named" \
                      "usr/sbin/resolvconf" "%{_sbindir}/resolvconf"
