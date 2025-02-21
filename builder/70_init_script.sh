#!/bin/bash

cat > $BUILD/init << EOF
#!/usr/bin/busybox ash

busybox mkdir -p /bin
busybox mount -t tmpfs none /bin
/usr/bin/busybox --install -s /bin

mkdir -p /dev
mkdir -p /proc
mkdir -p /sys

mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys

ash installer/install.sh
exec poweroff -f
EOF

chmod +x $BUILD/init
