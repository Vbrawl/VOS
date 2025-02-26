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

mkdir -p /install_media
install_media_found=0

for d in \$(ls /dev | grep -E '(sr|sd|nvme).*[0-9]')
do
  mount /dev/\$d /install_media
  magic_hash=\$(sha256sum /install_media/$MAGIC_FILE_NAME 2>/dev/null | cut -d ' ' -f 1)
  if [ "\$magic_hash" != "$MAGIC_FILE_HASH" ]
  then
    umount /install_media
    continue
  fi
  install_media_found=1
  break
done

openvt -c 2 -- getty -n -l /bin/ash 38400 tty2
openvt -c 3 -- getty -n -l /bin/ash 38400 tty3
openvt -c 4 -- getty -n -l /bin/ash 38400 tty4
openvt -c 5 -- getty -n -l /bin/ash 38400 tty5
openvt -c 6 -- getty -n -l /bin/ash 38400 tty6

if [ \$install_media_found -eq 1 ]
then
  openvt -c 7 -- /bin/ash /install_media/installer/install.sh
fi

getty -n -l /bin/ash 38400 tty1
exec poweroff -f
EOF

chmod +x $BUILD_INITRD/init
