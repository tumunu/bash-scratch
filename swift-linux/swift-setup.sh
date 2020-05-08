#!/bin/bash

#globals
version=alpha
name=swift-setup.sh

[ $# -eq 0 ] && {
	echo
	echo "$name $version"
	echo
	echo "Usage: $name -h"
	echo
	exit 1
}

help() {
	echo
	echo "Usage: $name -s [snapshot url] [/path/to/swift/root]"
	echo
	exit 1
}

# download package from swift.org
get_package() {
	echo "$1 <!"; echo "$2 <22"
	URL=$1
	cd $2
	FILE=${URL##*/} # FILE=whatever is after the last slash
	wget $1
	tar -zxvf $FILE
	rm $FILE
}

update_bashrc() {
	URL=$1
	FILE=${URL%%.*} # FILE=whatever is before the first full-stop
	sudo cp ~/.bashrc ~/.bashrc.ORG
	echo "PATH=$PATH:$2/$FILE/usr/bin" >> ~/.bashrc
	echo 
	echo "$ source ~/.bashrc"
	echo
}

setup() {
	if [[ $# -eq 0 ]]; then
		help
	fi

	DIR=$(echo $2 | sed 's:/*$::')	

	get_package $1 $DIR
	update_bashrc $1 $DIR
}

case $1 in
	-s)
		setup $2 $3
		;;
	-h)
		help
		;;
	*)
		help
		;;
esac

