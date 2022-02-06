#!/bin/bash

if [ $root ]
then
  mkfs.ext4 $root && mount $root /mnt && mkdir /mnt/boot || exit
else
  echo "Root partition not added. Read the README of the github repo."
  exit
fi

if [ $boot ]
then
  mkfs.fat -F32 $boot && mount $boot /mnt/boot || umount /mnt && exit
else
  echo "Boot partition not added. Read the README of the github repo."
  umount /mnt
  exit
fi

if [ $swap ]
then
  mkswap $swap && swapon $swap || umount /mnt && exit
fi

if [ $home ]
then
  mkfs.ext4 $home && mount $home /mnt/home || umount /mnt && exit
fi

if ! [ $kernel ]
then
  kernel=linux
fi

pacstrap /mnt base $kernel linux-firmware || exit
timedatectl set-ntp true
genfstab -U /mnt >> /mnt/etc/fstab
curl -L https://raw.githubusercontent.com/miguelrcborges/archinstallscript/main/chroot-script.sh -o /mnt/chroot-script.sh
arch-chroot /mnt sh chroot-script.sh
