#!/usr/bin/busybox ash

read -p "Welcome to VOS, would you like to proceed with the installation? [y/N] " PROCEED
PROCEED=$(echo "${PROCEED:0:1}" | tr '[:lower:]' '[:upper:]')

if [ "${PROCEED:0:1}" != "Y" ]
then
  for i in $(seq 3 -1 1)
  do
    echo -n -e "Shutting down in ${i}...\r"
    sleep 1
  done

  exit
fi

fdisk -l | grep Disk
read -p "Where should we install VOS? " DRIVE

while ! fdisk -l $DRIVE 2>/dev/null
do
  echo "Invalid input!"
  fdisk -l | grep Disk
  read -p "Where should we install VOS? " DRIVE
done

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

/usr/bin/mke2fs -t ext4 "${DRIVE}1"


mkdir -p /mnt
mount "${DRIVE}1" /mnt

chvt 1
