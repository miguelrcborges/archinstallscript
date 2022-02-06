#!/bin/bash

if [ $root ]
then
  mkfs.ext4 $root && mount $root /mnt || exit
else
  echo "Root partition not added. Run 'export root=<partition>' and re-run the script afterwards."
  umount /mnt
  exit
fi

if [ $boot ]
then
  mkfs.fat -F32 $boot && mkdir /mnt/boot && mount $boot /mnt/boot || umount /mnt && exit
else
  echo "Boot partition not added. Run 'export boot=<partition>' and re-run the script afterwards."
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
