#!/bin/bash

INITUP_SRC=$CACHE/initup
INITUP_RPM_NAME=InitUp
INITUP_VERSION="Latest"
INITUP_FULLNAME=$INITUP_RPM_NAME-$INITUP_VERSION

if [ ! -d $INITUP_SRC ]
then
  cd $CACHE
  git clone https://github.com/Vbrawl/initup $INITUP_SRC --depth 1
fi

if [ ! -d $INITUP_SRC/build ]
then
  cd $INITUP_SRC
  meson setup --cross-file $MESON_CROSS_FILE build
  meson compile -C build
fi

cd $INITUP_SRC/build
$ROOT/generate_tar.sh meson $INITUP_SRC/build/$INITUP_FULLNAME.tar $INITUP_FULLNAME \
                      bin/initup-gen \
                      sbin/{initup-init,initup-serviced}
#DESTDIR=$(pwd)/$INITUP_FULLNAME/usr meson install

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$INITUP_SRC/build/rpmbuild" \
                      "$INITUP_RPM_NAME" \
                      "$INITUP_VERSION" \
                      "InitUp init system and service manager" \
                      "InitUp is an init system aiming to be efficient, small and simple." \
                      "BSD-2" \
                      "$INITUP_SRC/build/$INITUP_FULLNAME.tar" \
                      "bin/initup-gen" "%{_bindir}/initup-gen" \
                      "sbin/initup-init" "%{_sbindir}/initup-init" \
                      "sbin/initup-serviced" "%{_sbindir}/initup-serviced"
