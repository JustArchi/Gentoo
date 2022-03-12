#!/usr/bin/env sh
set -eu

# Regenerate grub.cfg, only if system already has grub installed and making use of it
if [ -f "/boot/grub/grub.cfg" ] && command -v "grub-mkconfig" >/dev/null; then
    grub-mkconfig -o "/boot/grub/grub.cfg"
fi
