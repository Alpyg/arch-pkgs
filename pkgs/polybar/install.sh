#!/bin/bash
 
post_install() {
	ln -s "$(PWD)/config.ini" "$HOME/.config/polybar/config.ini"
}

post_remove() {
	rm "$HOME/.config/polybar/config.ini"
}
