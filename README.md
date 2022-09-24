# archinstallscript

## How to use

This installer uses variables exported. To export variables, do ```export <variable>=<value>```

### Variables

This variables must be exported
- root: ```/``` partition
- boot: ```/boot``` partiiton

Optional but recommended
- cpu: set it either to amd or to intel. It is used to install the microcodes.
- gpu: if unselected, installs the base drivers. Select it to nvidia, amd or intel.
- timezone: do ```ls /usr/share/zoneinfo``` to get available regions and ```ls /usr/share/zoneinfo/<Region>``` to get available citys. The format should be Region/City. Defauls to "Europe/Lisbon"
- rootpw: root user password. Defaults to "root"
- installtype: One of these values: minimal (only installs base arch and creates new user) and desktop. Defaults to minimal.
- desktop: Choose the Desktop Environment you want between gnome, kde and xfce. Defaults to gnome. *Only if installtype is set as desktop*
- username: Username for the user account. Defaults to "user"
- userpw: Password for the user account. Defaults to "user"
- winefi: Windows EFI partition to be detected by grub

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
