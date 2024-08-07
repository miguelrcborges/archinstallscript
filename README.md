# archinstallscript

## How to use

This installer uses exported variables. To export variables, use ```export <variable>=<value>```.
You can also use [this website](https://miguelrcborges.github.io/archinstallscript/) to generate the installation script.

### Variables

These variables must be exported:
- root: ```/``` partition
- boot: ```/boot``` partition
  - **NOTE**: Should be large enough to hold the kernels you want to install (and Windows' EFI if you want it to show up on systemd-boot). The Arch wiki recommends 512 MB, 300 MB should be enough for most cases, and around 90 MB should be sufficient if you are only using one kernel.

Optional but recommended:
- gpu: if unselected, installs the base drivers. Select it for nvidia, amd, or intel.
- timezone: Automatically detected using IP-based geolocation. No manual configuration needed.
- rootpw: root user password. Defaults to "root".
- installtype: One of these values: minimal (only installs base Arch and creates a new user) or desktop. Defaults to minimal.
- network: Variable to configure the system's network daemon. It can be systemd-networkd, networkmanager, dhcpcd, or none. Defaults to networkmanager.
- desktop: Choose the Desktop Environment you want: gnome, kde, or xfce. Defaults to gnome. **NEW** dwm value.
  - *Only if installtype is set to desktop*
- username: Username for the user account. Defaults to "user".
  - **NOTE**: Do not use uppercase letters. They are not supported in Linux usernames and will cause the user creation to fail.
- userpw: Password for the user account. Defaults to "user".
- winefi: Windows EFI partition to be detected by systemd-boot. If defined, its contents will be copied to your EFI partition, allowing systemd-boot to detect it and provide an option to boot into your Windows installation.

Optional:
- editor: either neovim, vim, or nano. Defaults to neovim.
- swap: swap partition.
- home: home partition.
- kernel: e.g., linux-zen.
- hostname: set a hostname instead of "arch".

DWM specific:
- dwmrepo: Repository of the dwm build you want to use. Defaults to mine.
- dwmrefresh: If you have a refresh variable in your dwm's config.h, it should change according to this variable.

Once you have set up the variables, run the installer script:
```sh
curl -L -s https://bit.ly/35SjPVH | sh
```

## Tips

You can create a repository with a bash script that exports the variables you want to make it easier to automate your future installs. Make sure that the repository is private, or assign password-related variables manually when installing (before running this script). [You can check an example here](https://github.com/miguelrcborges/archinstallscript/blob/main/example-base-script.sh).
