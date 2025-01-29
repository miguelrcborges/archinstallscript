#!/bin/bash

# Check if the system is in UEFI mode
if [ -d /sys/firmware/efi ]; then
  :
else
  # Not in UEFI mode, show error message
  echo "Error: This system is not booted in UEFI mode. UEFI is required for this installation."
  exit 1
fi

if [ $root ]; then
  mkfs.xfs -f $root || exit && mount $root /mnt && mkdir /mnt/boot
else
  echo "Root partition not added. Read the README of the github repo."
  exit
fi

if [ $boot ]; then
  mkfs.fat -F32 $boot || exit && mount $boot /mnt/boot
else
  echo "Boot partition not added. Read the README of the github repo."
  umount /mnt
  exit
fi

if [ $swap ]; then
  mkswap $swap || exit && swapon $swap
fi

if [ $home ]; then
  mkfs.xfs -f $home || exit && mount $home /mnt/home
fi

if ! [ $kernel ]; then
  export kernel=linux
fi

attempts=0
max_attempts=${max_attempts:-5}
while true; do
  if pacstrap /mnt base $kernel linux-firmware xfsprogs; then
    break
  fi
  attempts=$((attempts + 1))
  if [ $attempts -ge $max_attempts ]; then
    echo "Pacstrap failed after $max_attempts attempts."
    exit 1
  fi
  echo "Pacstrap failed. Retrying... (Attempt: $attempts/$max_attempts)"
done

timedatectl set-ntp true
genfstab -U /mnt >>/mnt/etc/fstab
curl -L https://raw.githubusercontent.com/miguelrcborges/archinstallscript/main/chroot-script.sh -o /mnt/chroot-script.sh
arch-chroot /mnt sh chroot-script.sh

if [ $network == "systemd-networkd" ]; then
  cp -r /etc/systemd/network /mnt/etc/systemd/
fi

reboot
