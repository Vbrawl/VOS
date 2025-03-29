#!/bin/bash

DHCPCD_SRC=$CACHE/dhcpcd
DHCPCD_RPM_NAME=Dhcpcd
DHCPCD_VERSION="10.2.2"
DHCPCD_FULLNAME=$DHCPCD_RPM_NAME-$DHCPCD_VERSION
$ROOT/download_and_untar.sh "https://github.com/NetworkConfiguration/dhcpcd/archive/refs/tags/v10.2.2.tar.gz" "$DHCPCD_SRC"

cd $DHCPCD_SRC

if [ ! -f $DHCPCD_SRC/src/dhcpcd ]
then
  ./configure --prefix=/usr --sysconfdir=/etc --target=$TARGET --host=$TARGET --without-udev
  make -j$(nproc)
fi

cd $DHCPCD_SRC
$ROOT/generate_tar.sh make $DHCPCD_SRC/$DHCPCD_FULLNAME.tar $DHCPCD_FULLNAME \
                      etc/dhcpcd.conf \
                      usr/libexec/dhcpcd-hooks/{01-test,20-resolv.conf,30-hostname,50-timesyncd.conf} \
                      usr/libexec/dhcpcd-run-hooks \
                      usr/sbin/dhcpcd \
                      usr/share/dhcpcd/hooks/{10-wpa_supplicant,15-timezone,29-lookup-hostname,50-yp.conf}

cd $DHCPCD_SRC
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$DHCPCD_SRC/rpmbuild" \
                      "$DHCPCD_RPM_NAME" \
                      "$DHCPCD_VERSION" \
                      "DHCP client daemon" \
                      "dhcpcd is a DHCP and a DHCPv6 client. It's also an IPv4LL (aka ZeroConf) client. In layperson's terms, dhcpcd runs on your machine and silently configures your computer to work on the attached networks without trouble and mostly without configuration." \
                      "BSD-2-Clause" \
                      "$DHCPCD_SRC/$DHCPCD_FULLNAME.tar" \
                      "etc/dhcpcd.conf" "%{_sysconfdir}/dhcpcd.conf" \
                      "usr/libexec/dhcpcd-hooks/01-test" "%{_libexecdir}/dhcpcd-hooks/01-test" \
                      "usr/libexec/dhcpcd-hooks/20-resolv.conf" "%{_libexecdir}/dhcpcd-hooks/20-resolv.conf" \
                      "usr/libexec/dhcpcd-hooks/30-hostname" "%{_libexecdir}/dhcpcd-hooks/30-hostname" \
                      "usr/libexec/dhcpcd-hooks/50-timesyncd.conf" "%{_libexecdir}/dhcpcd-hooks/50-timesyncd.conf" \
                      "usr/libexec/dhcpcd-run-hooks" "%{_libexecdir}/dhcpcd-run-hooks" \
                      "usr/sbin/dhcpcd" "%{_sbindir}/dhcpcd" \
                      "usr/share/dhcpcd/hooks/10-wpa_supplicant" "%{_datadir}/dhcpcd/10-wpa_supplicant" \
                      "usr/share/dhcpcd/hooks/15-timezone" "%{_datadir}/dhcpcd/15-timezone" \
                      "usr/share/dhcpcd/hooks/29-lookup-hostname" "%{_datadir}/dhcpcd/29-lookup-hostname" \
                      "usr/share/dhcpcd/hooks/50-yp.conf" "%{_datadir}/dhcpcd/50-yp.conf"
