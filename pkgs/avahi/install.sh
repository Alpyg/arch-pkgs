#!/bin/bash

post_install() {
    systemctl enable --now avahi-daemon
}

pre_remove() {
  systemctl disable --now avahi-daemon
}
