# Archi's Gentoo

## How to use this repo

- `git clone https://github.com/JustArchi/Gentoo`
- `ln -s` files that you deem wanted/useful, consider `cp` only when you want to refrain from their further updates by me. I generally suggest symlinking standalone files, but folders are possible as well.

## Overview

- `ArchiPC` includes stuff specific to my configuration, you may create your own while making use of mine for inspiration, but blindly copying anything from there most likely won't end good for you.
- `intel` includes stuff generic to all machines with Intel CPU. You don't want that stuff on AMD.
- `systemd` includes stuff generic to all machines with systemd init daemon. You don't want that stuff on OpenRC.
- `universal` includes universally good stuff. It may include stuff from other categories if I deem then as completely harmless, for example optional `/etc/crypttab` inclusion in dracut, despite being used solely by systemd.

## Features

### `gentoo-kernel`

I strongly advocate against wasting time maintaining your own kernel, while totally encouraging compilation and customization. This is why you can find a lot of parts that further enhance `gentoo-kernel` package.

- **[graysky's kernel patch](https://github.com/graysky2/kernel_compiler_patch)** for `gentoo-kernel`
- **[my own CFLAGS patch](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/portage/patches/sys-kernel/gentoo-kernel/CFLAGS.patch)**, which should be combined with **[gentooLTO](https://github.com/InBetweenNames/gentooLTO)** overlay for the best results, requires `gcc` with `graphite` USE flag
- **[automatic `grub.cfg` regeneration](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/postinst.d/99-grub.sh)**, triggers only if you're currently using `grub.cfg`, safe to include even on non-grub machines
- **[`-march=native` for intel](https://github.com/JustArchi/Gentoo/blob/main/intel/etc/kernel/config.d/intel-march-native.config)**
- **[`systemd` target](https://github.com/JustArchi/Gentoo/blob/main/systemd/etc/kernel/config.d/systemd.config)**
- **[`dm-crypt` built-in](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/cryptsetup.config)**, as module usually doesn't cut it
- **[Disabled io-delay](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/io-delay.config**
- **[`xz` compression](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/kernel-compression.config)**
- **[better responsiveness](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/responsiveness.config)**, includes `PREEMPT` and 1000 Hz interrupts
- **[`lz4`-optimized zram](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/zram.config)**
- **[`lz4`-optimized zswap](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/zswap.config)** and automatic enable
