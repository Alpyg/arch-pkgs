#!/bin/bash
 
post_install() {
  systemctl enable --now sshd
}

post_upgrade() {
  systemctl enable --now sshd
}

pre_remove() {
  systemctl disable --now sshd
}
