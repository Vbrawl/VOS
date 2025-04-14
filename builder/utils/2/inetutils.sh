#!/bin/bash

INETUTILS_SRC=$CACHE/inetutils
INETUTILS_RPM_NAME=InetUtils
INETUTILS_VERSION="2.6"
INETUTILS_FULLNAME=$INETUTILS_RPM_NAME-$INETUTILS_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz" "$INETUTILS_SRC"

if [ ! -d $INETUTILS_SRC/build ]
then
  mkdir -p $INETUTILS_SRC/build
  cd $INETUTILS_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess) --enable-year2038
  cat >> $INETUTILS_SRC/build/config.h << EOF
#ifndef PATH_PROCNET_DEV
#define PATH_PROCNET_DEV "/proc/net/dev"
#endif PATH_PROCNET_DEV
EOF
  make -j$(nproc)
fi
cd $INETUTILS_SRC/build

#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $INETUTILS_SRC/build/$INETUTILS_FULLNAME.tar $INETUTILS_FULLNAME \
                      usr/bin/{telnet,whois,ping,ftp,dnsdomainname,tftp,rsh,rexec,hostname,traceroute,rlogin,rcp,ping6,ifconfig} \
                      usr/libexec/{inetd,tftpd,syslogd,rlogind,talkd,rshd,telnetd}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$INETUTILS_SRC/build/rpmbuild" \
                      "$INETUTILS_RPM_NAME" \
                      "$INETUTILS_VERSION" \
                      "GNU Network Utilities" \
                      "The GNU Networking Utilities are the common networking utilities, clients and servers of the GNU Operating System developed by the GNU project." \
                      "GPL-3.0" \
                      "$INETUTILS_SRC/build/$INETUTILS_FULLNAME.tar" \
"usr/bin/telnet" "%{_bindir}/telnet" \
"usr/bin/whois" "%{_bindir}/whois" \
"usr/bin/ping" "%{_bindir}/ping" \
"usr/bin/ftp" "%{_bindir}/ftp" \
"usr/bin/dnsdomainname" "%{_bindir}/dnsdomainname" \
"usr/bin/tftp" "%{_bindir}/tftp" \
"usr/bin/rsh" "%{_bindir}/rsh" \
"usr/bin/rexec" "%{_bindir}/rexec" \
"usr/bin/hostname" "%{_bindir}/hostname" \
"usr/bin/traceroute" "%{_bindir}/traceroute" \
"usr/bin/rlogin" "%{_bindir}/rlogin" \
"usr/bin/rcp" "%{_bindir}/rcp" \
"usr/bin/ping6" "%{_bindir}/ping6" \
"usr/bin/ifconfig" "%{_bindir}/ifconfig" \
"usr/libexec/inetd" "%{_libexecdir}/inetd" \
"usr/libexec/tftpd" "%{_libexecdir}/tftpd" \
"usr/libexec/syslogd" "%{_libexecdir}/syslogd" \
"usr/libexec/rlogind" "%{_libexecdir}/rlogind" \
"usr/libexec/talkd" "%{_libexecdir}/talkd" \
"usr/libexec/rshd" "%{_libexecdir}/rshd" \
"usr/libexec/telnetd" "%{_libexecdir}/telnetd"
