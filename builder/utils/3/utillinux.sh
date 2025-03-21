#!/bin/bash

UTILLINUX_SRC=$CACHE/utillinux

$ROOT/download_and_untar.sh "https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41-rc2.tar.xz" "$UTILLINUX_SRC"

if [ ! -d $UTILLINUX_SRC/build ]
then
  mkdir -p $UTILLINUX_SRC/build
  cd $UTILLINUX_SRC/build
  ../configure --prefix=/usr \
                --build=$(../config/config.guess) \
                --host=$TARGET \
                --enable-usrdir-path \
                --disable-switch_root \
                --disable-pivot_root \
                --disable-liblastlog2 \
                --disable-makeinstall-chown \
                --disable-makeinstall-setuid \
                --disable-makeinstall-tty-setgid \
                --without-tinfo \
                --without-systemd
  sed -i "s/-ltinfo//g" Makefile
  make -j$(nproc)
fi
cd $UTILLINUX_SRC/build
make DESTDIR=$ISO_SYSROOT install

for f in dmesg kill lsblk more mountpoint umount findmnt login lsfd mount pipesz su wdctl
do
  mv $ISO_SYSROOT/bin/$f $ISO_SYSROOT/usr/bin/$f
done

mv $ISO_SYSROOT/lib/* $ISO_SYSROOT/usr/lib
rm -r $ISO_SYSROOT/lib
