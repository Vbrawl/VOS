#!/bin/bash

cat > $BUILD_INITRD/init << EOF
#!/bin/busybox ash

/bin/busybox --install -s /bin

mkdir -p /dev
mkdir -p /proc
mkdir -p /sys

mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys


openvt -c 2 -- getty -n -l /bin/ash 38400 tty2
openvt -c 3 -- getty -n -l /bin/ash 38400 tty3
openvt -c 4 -- getty -n -l /bin/ash 38400 tty4
openvt -c 5 -- getty -n -l /bin/ash 38400 tty5
openvt -c 6 -- getty -n -l /bin/ash 38400 tty6
openvt -c 7 -- /bin/ash /installer/install.sh

getty -n -l /bin/ash 38400 tty1
exec poweroff -f
EOF

chmod +x $BUILD_INITRD/init
