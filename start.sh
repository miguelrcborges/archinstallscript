#!/bin/bash

if [ $root ]
then
  mkfs.xfs -f $root || exit && mount $root /mnt && mkdir /mnt/boot 
else
  echo "Root partition not added. Read the README of the github repo."
  exit
fi

if [ $boot ]
then
  mkfs.fat -F32 $boot || exit && mount $boot /mnt/boot
else
  echo "Boot partition not added. Read the README of the github repo."
  umount /mnt
  exit
fi

if [ $swap ]
then
  mkswap $swap || exit && swapon $swap
fi

if [ $home ]
then
  mkfs.xfs -f $home || exit && mount $home /mnt/home
fi

if ! [ $kernel ]
then
  export kernel=linux
fi

pacstrap /mnt base $kernel $kernel-headers linux-firmware || exit
timedatectl set-ntp true
genfstab -U /mnt >> /mnt/etc/fstab
curl -L https://raw.githubusercontent.com/miguelrcborges/archinstallscript/main/chroot-script.sh -o /mnt/chroot-script.sh
arch-chroot /mnt sh chroot-script.sh

if [ $network == "systemd-networkd" ]
then
  cp -r /etc/systemd/network /mnt/etc/systemd/network
fi

reboot
