# archinstallscript

## How to use

This installer uses variables exported. To export variables, do ```export <variable>=<value>```

### Variables

This variables must be exported
- root: ```/``` partition
- boot: ```/boot``` partiiton

Optional but recommended
- gpu: if unselected, installs the base drivers. Select it to nvidia, amd or intel.
- timezone: do ```ls /usr/share/zoneinfo``` to get available regions and ```ls /usr/share/zoneinfo/<Region>``` to get available citys. The format should be Region/City. Defauls to "Europe/Lisbon"
- rootpw: root user password. Defaults to "root"
- installtype: One of these values: minimal (only installs base arch and creates new user) and desktop. Defaults to minimal.
- desktop: Choose the Desktop Environment you want between gnome, kde and xfce. Defaults to gnome. *Only if installtype is set as desktop*
- username: Username for the user account. Defaults to "user".
  - NOTE: Don't use uppercase letters. They aren't supported on linux usernames and it will fail to create your user.
- userpw: Password for the user account. Defaults to "user"
- ~~winefi: Windows EFI partition to be detected by grub~~ Moved to systemd-boot. The automatation of adding windows boot manager entry to the bootloader hasn't been done yet, but can be done checking [this](https://wiki.archlinux.org/title/systemd-boot#Boot_from_another_disk). You can also just change boot order on UEFI.

Optional
- editor: either neovim, vim or nano. Defaults to nvim.
- swap: swap partition
- home: home partition
- kernel: eg. linux-zen
- hostname: set a hostname instead of "arch"


Once you are done setting up the variables, run the installer script:
```
curl -L -s https://bit.ly/35SjPVH | sh
```


## Tips

You can create a repository with a bash script that exports the variables you want to make it easier to automate your future installs. Make sure that the repository is private or assign password related variables manually when installing (before running this script). [You can check an example here](https://github.com/miguelrcborges/archinstallscript/blob/main/example-base-script.sh)
