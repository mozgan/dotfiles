#!/bin/sh
#

screenshot() {
  mkdir -p ~/Pictures/Screenshots
  cd ~/Pictures/Screenshots/

	case $1 in
	full)
		scrot -m
		;;
	window)
		sleep 1
		scrot -s
		;;
	*)
		;;
	esac;
}

screenshot $1
