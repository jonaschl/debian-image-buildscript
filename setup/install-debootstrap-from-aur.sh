#!/bin/bash
pacman -S --needed base-devel
wget -c https://aur.archlinux.org/cgit/aur.git/snapshot/debootstrap.tar.gz
tar -xvf debootstrap.tar.gz
(cd debootstrap || exit
makepkg -sri)
