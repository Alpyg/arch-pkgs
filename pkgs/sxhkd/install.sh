#!/bin/bash
 
post_install() {
	ln -s "$(PWD)/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"
}

post_remove() {
	rm "$HOME/.config/sxhkd/sxhkdrc"
}
