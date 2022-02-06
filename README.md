# archinstallscript

In order to use it, run:
```
curl -L -s https://bit.ly/35SjPVH | sh
```

This variables must be exported
- root: ```/``` partition
- boot: ```/boot``` partiiton
- timezone: do ```ls /usr/share/zoneinfo``` to get available regions and ```ls /usr/share/zoneinfo/<Region>``` to get available citys. The format should be Region/City. eg. "Europe/Lisbon"
- rootpw: root user password (otherwise it will be root)

Optional but recommended
- cpu: set it either to amd or to intel. It is used to install the microcodes.

Optinal
- swap: swap partition
- home: home partition
- kernel: eg. linux-zen
- hostname: set a hostname instead of "arch"
