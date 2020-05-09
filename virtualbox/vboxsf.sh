#!/bin/bash

#globals 
version=alpha
name=vboxsf.sh

helper() {
	echo 
	echo "Usage: $name -f | --fix [remote share name][/path/to/local/directory]"
	echo "e.g. $name -f temp /tmp"
	echo
	exit 1
}

fix_vboxsf() {
	# check for arguments
	if [ "$1"];  then
		helper
	else
		sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) $1 $2
	fi
}

case $1 in
	-f | --fix)
		fix_vboxsf $2 $3
		;;
	*)
		helper
		;;
esac
	
