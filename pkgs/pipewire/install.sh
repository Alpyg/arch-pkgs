#!/bin/bash
 
post_install() {
  systemctl --user enable --now pipewire
}

pre_remove() {
  systemctl --user disable --now pipewire
}
