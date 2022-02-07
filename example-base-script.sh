#!/bin/bash

if ! [ $rootpw ]
then
  echo "Add a root password before running this script!"
  exit
fi

if ! [ $userpw ]
then
  echo "Add a password for your user before running this script!"
  exit
fi

export boot=/dev/sda1
export root=/dev/sda2
export cpu=intel

export username=miguel
export hostname=pc
export timezone=Europe/Lisbon
export installtype=desktop
export desktop=gnome

export kernel=linux-zen

curl -L -s https://bit.ly/35SjPVH | sh
