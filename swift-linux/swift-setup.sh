#!/bin/bash

#globals
version=alpha
name=swift-setup.sh

# download package from swift.org
get_package() {
	cd $2
	FILE=${$1##*/} # FILE=whatever is after the last slash
	wget $1
	tar -zxvf $FILE
	rm $FILE
}

update_bashrc() {
	FILE=${$1%%.*} # FILE=whatever is bwfoew the first full-stop
	sudo cp ~/.bashrc ~/.bashrc.ORG
	echo "PATH=$PATH:$2/$FILE/usr/bin" >> ~/.bashrc
	echo 
	echo "$ source ~/.bashrc"
	echo
}

setup() {
	if [ $1=="" ] || [ $# -gt 1 ]; then
		echo
		echo "Usage: $name -s [snapshot url] [/path/to/swift/root]"
		echo
		exit 1
	fi

	DIR=$(echo $2 | sed 's:/*$::')	

	get_package $1 $DIR
	update_bashrc $1 $DIR
}

case $1 in
	-s)
		setup $2 $3
		;;
	*)
		echo
		echo "Usage: $name -s [snaphot url] [/path/to/swift/root]"
		echo
		exit 1
		;;
esac

