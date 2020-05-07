#!/bin/bash

#globals 
version=alpha
name=vboxsf.sh

fix_vboxsf() {
	# check for arguments
	if [ "$1" == "" ] || [ $# -gt 1 ]; then
		echo
		echo "Usage: $name -f | --fix [remote share name][/path/to/local/directory]"
		echo "e.g. $name -f temp /tmp"
		exit 1
	else
		sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) $1 $2
	fi
}

case $1 in
	-f | --fix)
		fix_vboxsf $2 $3
		;;
	*)
		echo
		echo "Usage: $name -f | --fix [remote share name][/path/to/local/directory]"
		echo
		exit 1
		;;
esac
	
