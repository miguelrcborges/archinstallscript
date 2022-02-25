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

if ! [ $editor ]
then
  editor="neovim"
fi

pacman --noconfirm -S grub efibootmgr os-prober $editor networkmanager base-devel

if [ $cpu ]
then
  pacman --noconfirm -S $cpu-ucode
fi

if [ $winefi ]
then
  mkdir /mnt2
  mount $winefi /mnt2
fi

sed -i "/^#GRUB_DISABLE_OS_PROBER/ cGRUB_DISABLE_OS_PROBER=false" /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager

if [ $winefi ]
then
  umount $winefi
  rm -rf /mnt2
fi

if ! [ $rootpw ]
then
  rootpw="root"
fi
if ! [ $username ]
then
  username="user"
fi
if ! [ $userpw ]
then
  userpw="user"
fi

echo "root:$rootpw" | chpasswd
useradd -mg wheel $username
echo "$username:$userpw" | chpasswd
sed -i "/^# %wheel ALL=(ALL:ALL) ALL/ c%wheel ALL=(ALL:ALL) ALL" /etc/sudoers

if ! [ $installtype ] || [ $installtype == "minimal" ]
then
  exit
fi

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy
pacman --noconfirm -S xorg lib32-mesa noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra pulseaudio pulseaudio-alsa

case $gpu in 
  nvidia)
    pacman -S --noconfirm --needed lib32-libglvnd lib32-nvidia-utils lib32-vulkan-icd-loader libglvnd nvidia-dkms nvidia-settings vulkan-icd-loader
    ;;
    
  amd)
    pacman -S --noconfirm --needed xf86-video-amdgpu mesa lib32-mesa gamescope lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-icd-loader vulkan-radeon
    ;;
  
  intel)
    pacman -S --noconfirm --needed mesa lib32-mesa gamescope lib32-vulkan-icd-loader lib32-vulkan-intel vulkan-icd-loader vulkan-intel
    ;;
  
  *)
    pacman -S --noconfirm xf86-video-amdgpu xf86-video-intel xf86-video-nouveau
    ;;
esac

sed -i "/^; default-sample-format/ cdefault-sample-format = float32le" /etc/pulse/daemon.conf
sed -i "/^; default-sample-rate/ cdefault-sample-rate = 48000" /etc/pulse/daemon.conf
sed -i "/^; alternate-sample-rate / calternate-sample-rate = 44100" /etc/pulse/daemon.conf
sed -i "/^; resample-method/ cresample-method = speex-float-3" /etc/pulse/daemon.conf

su $user -c "cd && echo $userpw | sudo --stdin pacman -Syu && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay"

if [ $installtype == "autorice" ]
then
  curl -L https://raw.githubusercontent.com/miguelrcborges/archinstallscript/main/rice.sh -s | sh
  exit
fi

if [ $installtype == "desktop" ]
then
  case $desktop in
    kde)
      pacman -S --noconfirm plasma konsole dolphin
      systemctl enable sddm
      ;;
    
    xfce)
      pacman -S --noconfirm xfce4 xfce4-goodies lxdm
      systemctl enable lxdm
      ;;
    
    *)
      pacman -S --noconfirm gnome
      systemctl enable gdm
      ;;
  esac
fi
     
