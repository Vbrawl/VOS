#!/bin/bash

BOOTLOADER_VERSION=syslinux-6.03
BOOTLOADER_SRC=$CACHE/$BOOTLOADER_VERSION
BOOTLOADER_DEST=$BUILD_ISO/isolinux

if [ ! -d $BOOTLOADER_SRC ]
then
  curl https://www.kernel.org/pub/linux/utils/boot/syslinux/$BOOTLOADER_VERSION.tar.gz \
  | tar -xzf - -C $CACHE
fi

mkdir -p $BOOTLOADER_DEST

cp $BOOTLOADER_SRC/bios/core/isolinux.bin $BOOTLOADER_DEST/isolinux.bin
cp $BOOTLOADER_SRC/bios/com32/menu/menu.c32 $BOOTLOADER_DEST/menu.c32
cp $BOOTLOADER_SRC/bios/com32/libutil/libutil.c32 $BOOTLOADER_DEST/libutil.c32
cp $BOOTLOADER_SRC/bios/com32/elflink/ldlinux/ldlinux.c32 $BOOTLOADER_DEST/ldlinux.c32

cat > $BOOTLOADER_DEST/isolinux.cfg << EOF
DEFAULT INSTALLER
UI menu.c32
MENU TITLE VOS
LABEL INSTALLER
  MENU LABEL VOS [CLI Installer]
  LINUX /vmlinuz-${KERNEL_MAJOR_VERSION}.${KERNEL_MINOR_VERSION}.${KERNEL_PATCH_VERSION}
  INITRD /initrd
  APPEND quiet
  TEXT HELP
    Install VOS
  ENDTEXT
EOF
