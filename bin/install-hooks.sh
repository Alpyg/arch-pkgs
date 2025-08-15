#!/bin/bash
 
sudo mkdir -p /etc/pacman.d/hooks

for f in hooks/*.hook; do
    sudo ln -sf "$(pwd)/$f" /etc/pacman.d/hooks/
done
