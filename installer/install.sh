#!/bin/busybox ash

set -e

read -p "Welcome to VOS, would you like to proceed with the installation? [y/N] " PROCEED
PROCEED=$(echo "${PROCEED:0:1}" | tr '[:lower:]' '[:upper:]')

if [ "$PROCEED" != "Y" ]
then
  for i in $(seq 3 -1 1)
  do
    echo -n -e "Shutting down in ${i}...\r"
    sleep 1
  done

  exit
fi

fdisk -l | grep Disk || true
read -p "Where should we install VOS? " DRIVE

fdisk $DRIVE << EOF
o
n
p
1


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
chvt 1

