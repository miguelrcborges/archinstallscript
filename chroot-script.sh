#!bin/sh

ln -sf /usr/share/zoneinfo/$timezone /etc/localtime || echo "Invalid timezone, set a valid one and then run 'arch-chroot /mnt sh chroot-script.sh'" && exit
hwclock --systohc
sed -i "/^#en_US.UTF-8/ cen_US.UTF-8 UTF-8" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

if ! [ $hostname ]
then
  hostname="arch"
fi

echo $hostname >> /etc/hostname

pacman -S grub efibootmgr os-prober vim

if [ $cpu ]
then
  pacman -S $cpu-ucode
fi

sed -i "/^#GRUB_DISABLE_OS_PROBER/ cGRUB_DISABLE_OS_PROBER=true" /etc/locale.gen
grub-install --target=x86_64-efi --efi-directory=$boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

passwd
