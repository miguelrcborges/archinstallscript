#!bin/sh

if ! [ $timezone ]
then
  timezone="Europe/Lisbon"
fi

ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock --systohc
sed -i "/^#en_US.UTF-8/ cen_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

if ! [ $hostname ]
then
  hostname="arch"
fi

echo $hostname >> /etc/hostname

pacman --noconfirm -S grub efibootmgr os-prober vim networkmanager

if [ $cpu ]
then
  pacman --noconfirm -S $cpu-ucode
fi

sed -i "/^#GRUB_DISABLE_OS_PROBER/ cGRUB_DISABLE_OS_PROBER=true" /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

if ! [ $rootpw ]
then
  rootpw="root"
fi

echo "root:$rootwd" | chpasswd
