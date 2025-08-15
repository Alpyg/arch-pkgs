#!/bin/bash
 
post_install() {
  systemctl enable --now zerotier-one

  # TODO: join network from secret file
}

post_upgrade() {
  systemctl enable --now zerotier-one
}

pre_remove() {
  systemctl disable --now zerotier-one
  
  # TODO: leave network from secret file
}
