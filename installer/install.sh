#!/bin/busybox ash

set -e

read -p "Welcome to VOS, would you like to proceed with the installation? [y/N] " PROCEED
PROCEED=$(echo "${PROCEED:0:1}" | tr '[:lower:]' '[:upper:]')

if [ "$PROCEED" == "Y" ]
then
# Most of the script in "if Y" statement

fdisk -l | grep Disk || true
read -p "Where should we install VOS? " DRIVE

fdisk $DRIVE << EOF
o
n
p
1
2048

a
1
w
q
EOF

mke2fs -t ext4 "${DRIVE}1"


mkdir -p /mnt
mount "${DRIVE}1" /mnt

echo "Copying filesystem!"
cp -r /install_media/fs/* /mnt

echo "Writing /etc/fstab"
mkdir -p /mnt/etc
mkdir -p /mnt/sys
mkdir -p /mnt/proc
mkdir -p /mnt/var/tmp
mkdir -p /mnt/tmp
echo "${DRIVE}1 / ext4 rw 0 1" > /mnt/etc/fstab
echo "none /sys sysfs rw 0 1" >> /mnt/etc/fstab
echo "none /proc proc rw 0 1" >> /mnt/etc/fstab
echo "none /dev devtmpfs rw 0 1" >> /mnt/etc/fstab
echo "none /var/tmp tmpfs rw,mode=1777 0 1" >> /mnt/etc/fstab
echo "none /tmp tmpfs rw,mode=1777 0 1" >> /mnt/etc/fstab


echo "Installing grub!"
mkdir -p /mnt/dev
mount --bind /dev /mnt/dev
chroot /mnt /usr/sbin/grub-install $DRIVE

for f in $(find /install_media/ | grep -E "vmlinuz-")
do
  cp $f /mnt/boot/
  chroot /mnt /usr/bin/initup-gen -i /usr/sbin/initup-init -o /boot/initrd-$(echo $f | sed 's/.*vmlinuz-//g')
done

chroot /mnt /usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg

chroot /mnt /sbin/ldconfig
mkdir -p /mnt/mnt
mount --bind /install_media/rpms /mnt/mnt
for f in $(ls /install_media/rpms)
do
  chroot /mnt /usr/bin/rpm --nodeps -i /mnt/$f
done

echo "Installation complete!"
# End of "if Y" statement
fi

for i in $(seq 3 -1 1)
do
  echo -n -e "Powering off in ${i}...\r"
  sleep 1
done

poweroff -f
