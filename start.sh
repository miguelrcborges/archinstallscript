#!/bin/bash

if [ $root ]
then
  mkfs.ext4 $root
  mount $root /mnt
else
  echo "Root partition not added. Run 'export root=<partition>' and re-run the script afterwards."
  umount /mnt
  exit
fi

if [ $boot ]
then
  mkfs.fat -F32 $boot
  mount $boot /mnt/boot
else
  echo "Boot partition not added. Run 'export boot=<partition>' and re-run the script afterwards."
  umount /mnt
  exit
fi

if [ $swap ]
then
  mkswap $swap
  swapon $swap
fi

if [ $home ]
then
  mkfs.ext4 $home
  mount $home /mnt/home
fi
