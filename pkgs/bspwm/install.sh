#!/bin/bash

post_install() {
	mkdir -p "$home/.config/bspwm"
	ln -s "$pkg_dir/bspwmrc" "$home/.config/bspwm/bspwmrc"
	chown -R "$user:$user" "$home/.config/bspwm"
}

post_remove() {
	rm -rf "$home/.config/bspwm"
}
