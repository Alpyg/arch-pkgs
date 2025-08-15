#!/bin/bash
 
post_install() {
  systemctl --user enable --now wireplumber
}

pre_remove() {
  systemctl --user disable --now wireplumber
}
