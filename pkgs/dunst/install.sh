#!/bin/bash
 
post_install() {
	ln -s "$(PWD)/dunstrc" "$HOME/.config/dunst/dunstrc"
}

post_remove() {
	rm "$HOME/.config/dunst/dunstrc"
}
