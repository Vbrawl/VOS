#!/usr/bin/busybox ash

read -p "Welcome to VOS Installer, would you like to proceed with the installation? [y/N] " PROCEED
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

echo "Not Quitting"
ash
