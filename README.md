# e28xx DKMS Patcher

This repository provides a DKMS module patch to add support for the **Hauppauge USB-Live 2 (Revision E1)** to the Linux `em28xx` driver family.
This new card revision is based off of a new Empia chipset which has a built-in decoder.

The original `em28xx` driver has been copied from the 6.16 kernel tree and supplemented with a patch file that enables the support.
It enables plug-and-play usage of the newer hardware revision in kernel 6.16+ using a clean DKMS approach.

---

## Overview

- Adds the missing USB VID/PID entry and driver logic for Hauppauge USB-Live 2 Rev. E1.
- The code is based off of Hauppauge's endorsed and publically released driver (in `b-rad/kernel+mediatree+hauppauge` PPA).
- Wraps a patch file that applies to the kernel 6.16+ `em28xx` driver in a DKMS package so it automatically rebuilds on kernel updates.
- Leaves the rest of the kernel sources untouched.
- DVB and remote control components are not compiled with this driver.

---

## Code Origin

The patch is surgically adapted from `linux_6.11.0-17250128.0+mediatree+hauppauge.diff.gz` in the Hauppauge PPA which includes the source code.
https://launchpad.net/~b-rad/+archive/ubuntu/kernel+mediatree+hauppauge/+sourcepub/16956120/+listing-archive-extra

That diff includes the relevant driver source code but no new license terms. The driver remains licensed under GPL v2.0, consistent with the original kernel media tree.

---

## Requirements

- Linux kernel headers installed for your current kernel
- `dkms`
- `build-essential` (or equivalent toolchain packages)

On Debian/Ubuntu:

```bash
sudo apt-get install -y dkms build-essential linux-headers-$(uname -r)
```

---

## Usage

Copy to `/usr/src/em28xx-dkms-1.0` and install with DKMS:

```bash
sudo dkms add -m em28xx-dkms -v 1.0
sudo dkms build -m em28xx-dkms -v 1.0
sudo dkms install -m em28xx-dkms -v 1.0
sudo depmod -a
```

Then unload the old em28xx driver (or reboot):
```bash
sudo rmmod em28xx
```

Finally load the new driver
```bash
sudo modprobe em28xx
```

---

## Uninstallation

```bash
sudo dkms uninstall -m em28xx-dkms -v 1.0
sudo dkms remove -m em28xx-dkms/1.0
sudo rmmod em28xx
```
