#!/bin/bash

cat > $BUILD_SYSTEM_INITRD/init << EOF
#!/bin/busybox ash

busybox mkdir -p /dev
busybox mount -t devtmpfs none /dev

busybox mkdir -p /root
busybox mount -t ext4 /dev/sda1 /root

busybox mkdir -p /root/dev
busybox mkdir -p /root/proc
busybox mkdir -p /root/sys
busybox mkdir -p /root/var

busybox mount -t devtmpfs none /root/dev
busybox mount -t proc none /root/proc
busybox mount -t sysfs none /root/sys
busybox mount -t tmpfs none /root/var

busybox mkdir -p /root/var/run

busybox chroot /root /usr/sbin/dhcpcd

exec busybox chroot /root /bin/bash
EOF

chmod +x $BUILD_SYSTEM_INITRD/init
