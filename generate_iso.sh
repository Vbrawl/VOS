#!/bin/bash

genisoimage -rational-rock -volid "VOS Installation Media" -cache-inodes \
-joliet -full-iso9660-filenames -input-charset UTF8 -b isolinux/isolinux.bin \
-c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
-output $DIST/installer.iso $BUILD_ISO
