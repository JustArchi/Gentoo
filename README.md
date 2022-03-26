# Archi's Gentoo

## How to use this repo

- `git clone --recursive https://github.com/JustArchi/Gentoo`
- `ln -s` files that you deem wanted/useful, consider `cp` only when you want to refrain from their further updates by me. I generally suggest symlinking standalone files, but folders are possible as well.

## Overview

- `ArchiPC` includes stuff specific to my configuration, you may create your own while making use of mine for inspiration, but blindly copying anything from there most likely won't end good for you.
- `intel` includes stuff generic to all machines with Intel CPU. You don't want that stuff on AMD.
- `systemd` includes stuff generic to all machines with systemd init daemon. You don't want that stuff on `OpenRC`.
- `universal` includes universally good stuff. It may include stuff from other categories if I deem it as completely harmless, for example optional `/etc/crypttab` inclusion in dracut, despite being used solely by `systemd`.

## Features

### `dracut`

- **[`hostonly`](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/dracut.conf.d/hostonly.conf)**, a VERY important part which makes `cryptsetup` on `systemd` a breeze, with not a single `grub` cmdline arg needed, on top of not embedding things that you don't need
- **[`xz` compression](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/dracut.conf.d/xz.conf)**, arguments for `xz` same as kernel compression

### `env.d`

- **[Disabled telemetry for `dotnet`](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/env.d/40dotnet)**

### `gentoo-kernel`

I strongly advocate against wasting time maintaining your own kernel, while totally encouraging compilation and customization. This is why you can find a lot of parts here that further enhance `gentoo-kernel` package - parts that I classify as useful patches to adapt the kernel the way I want, without being forced to create a new config file with every minor release.

Instead of spending hours if not days creating your own kernel config (and usually still failing at it), I prefer "distribution config patching" approach instead, which allows you to patch the config prior to kernel compilation automatically based on your configuration, which instead results in maximum compatibility and customization, while still allowing distro maintainers to do their thing right and build minimal modular kernel for you to use. No, disabling all the modules won't make your kernel perform better, it'll only cut on compilation time - unused modules are not causing overhead. Distro configs are already very nicely optimized and only crucial stuff is marked as `built-in`.

- **[graysky's kernel patch](https://github.com/graysky2/kernel_compiler_patch)** for `gentoo-kernel`, this one is included with `experimental` USE flag for `gentoo-sources`, but no such feature for `gentoo-kernel`, sadly
- **[my own CFLAGS patch](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/portage/patches/sys-kernel/gentoo-kernel/CFLAGS.patch)**, which should be combined with **[gentooLTO](https://github.com/InBetweenNames/gentooLTO)** overlay for the best results, requires `gcc` with `graphite` USE flag - highly experimental, works fine for me, but you've been warned
- **[automatic `grub.cfg` regeneration](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/postinst.d/99-grub.sh)**, triggers only if you're currently using `grub.cfg`, safe to include even on non-grub machines, **should be offered by Gentoo itself**
- **[`-march=native` for intel](https://github.com/JustArchi/Gentoo/blob/main/intel/etc/kernel/config.d/intel-march-native.config)**, requires **[graysky's kernel patch](https://github.com/graysky2/kernel_compiler_patch)**, otherwise is a no-op when applied, naturally you don't want that on AMD
- **[`systemd` target](https://github.com/JustArchi/Gentoo/blob/main/systemd/etc/kernel/config.d/systemd.config)**, naturally you don't want that on `OpenRC`
- **[`dm-crypt` built-in](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/cryptsetup.config)**, as module usually doesn't cut it, rendering booting unusable
- **[Disabled io-delay](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/io-delay.config)**, not needed for modern machines, use at your own risk
- **[`xz` compression](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/kernel-compression.config)**, gives the best compression ratio and very good decompression speed, overall boots faster compared to `gzip` on my `x64` machine
- **[Better responsiveness](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/responsiveness.config)**, includes `PREEMPT` and 1000 Hz interrupts
- **[`lz4`-optimized zram](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/zram.config)**, `lz4` is currently winning fastest decompression competition, it should be used instead of other alternatives such as `lzo`
- **[`lz4`-optimized zswap](https://github.com/JustArchi/Gentoo/blob/main/universal/etc/kernel/config.d/zswap.config)**, as per above, and automatic enable of it, as I/O access is crucial
