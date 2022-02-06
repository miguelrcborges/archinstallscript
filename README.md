# archinstallscript

In order to use it, run:
```
curl -L -s https://bit.ly/35SjPVH | sh
```

This variables must be exported
- root: ```/``` partition
- boot: ```/boot``` partiiton

Optional but recommended
- cpu: set it either to amd or to intel. It is used to install the microcodes.
- timezone: do ```ls /usr/share/zoneinfo``` to get available regions and ```ls /usr/share/zoneinfo/<Region>``` to get available citys. The format should be Region/City. Defauls to "Europe/Lisbon"
- rootpw: root user password. Defaults to "root"

Optional
- swap: swap partition
- home: home partition
- kernel: eg. linux-zen
- hostname: set a hostname instead of "arch"
