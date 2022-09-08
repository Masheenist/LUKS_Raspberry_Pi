#!/bin/bash

sudo apt install busybox cryptsetup initramfs-tools

sudo cp initramfs-rebuild /etc/kernel/postinst.d/

sudo chmod +x /etc/kernel/postinst.d/initramfs-rebuild

sudo chmod +x /etc/initramfs-tools/hooks/luks_hooks

sudo nano /etc/initramfs-tools/modules

sed -i "algif_skcipher
xchacha20
adiantum
aes_arm
sha256
nhpoly1305
dm-crypt" /etc/initramfs-tools/modules

sudo -E CRYPTSETUP=y mkinitramfs -o /boot/initramfs.gz

lsinitramfs /boot/initramfs.gz | grep -P "sbin/(cryptsetup|resize2fs|fdisk)"

sed - "followkernel" /boot/initramfs.gz

Sudo reboot
