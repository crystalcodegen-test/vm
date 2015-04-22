#!/bin/sh

# validate action
if [ ! "$1" ]; then
	echo "Action is required"
	exit
fi
action=$1

# validate database
if [ ! "$2" ]; then
	echo "Database is required"
	exit
fi
database=$2

# set file
file=$database.sql

# change to dump dir
cd /code/default/vm/dump

# export database
ssh $server "mysqldump -u root --password='' $database > $file"

# download database
sftp $server << Load
get $file $file-temp
Load

# rename file
mv $file-temp $file
