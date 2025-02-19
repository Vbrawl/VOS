#!/bin/bash

BOOTLOADER_VERSION=syslinux-6.03
BOOTLOADER_SRC=$CACHE/$BOOTLOADER_VERSION
BOOTLOADER_DEST=$BUILD/isolinux

if [ ! -d $BOOTLOADER_SRC ]
then
  curl https://www.kernel.org/pub/linux/utils/boot/syslinux/$BOOTLOADER_VERSION.tar.gz \
  | tar -xzf - -C $CACHE
fi

if [ ! -d $BOOTLOADER_DEST ]
then
  mkdir -p $BOOTLOADER_DEST
fi

cp $BOOTLOADER_SRC/bios/core/isolinux.bin $BOOTLOADER_DEST/isolinux.bin
cp $BOOTLOADER_SRC/bios/com32/menu/menu.c32 $BOOTLOADER_DEST/menu.c32
cp $BOOTLOADER_SRC/bios/com32/libutil/libutil.c32 $BOOTLOADER_DEST/libutil.c32
cp $BOOTLOADER_SRC/bios/com32/elflink/ldlinux/ldlinux.c32 $BOOTLOADER_DEST/ldlinux.c32

cat > $BOOTLOADER_DEST/isolinux.cfg << EOF
DEFAULT INSTALLER
UI menu.c32
MENU TITLE "VOS"
LABEL INSTALLER
  MENU LABEL VOS [CLI Installer]
  LINUX /vmlinuz
  INITRD /initrd
  TEXT HELP
    boot cli installer for VOS
  ENDTEXT
EOF

export BOOTLOADER_BIN=isolinux/isolinux.bin
export BOOTLOADER_CAT=isolinux/boot.cat
