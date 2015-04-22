#!/bin/sh

# validate image name
if [ ! "$1" ]; then
	image_name=ubuntu-14.04
else
	image_name=$1
fi

# validate image
image=image/$image_name.vdi

# validate machine
if [ ! "$2" ]; then
	machine=default
else
	machine=$2
fi

# validate path
if [ ! "$3" ]; then
	machine_path=/Developer/Atom/vm/default
else
	machine_path=$3
fi

# stop current machine
echo "SHUTTING DOWN $machine:"
VBoxManage controlvm $machine poweroff

# delete current machine
echo "\nDELETING $machine:"
VBoxManage unregistervm $machine --delete

# go to root
dir=/Developer/Atom/vm
cd $dir

# define date
date=$(date +"%Y-%m-%d_%H.%M.%S")

# define source & destination
disk=$machine_path/disk/$image_name\_$date.vdi

# clone vdi
echo "\nCLONING $image_name:"
VBoxManage clonehd $image $disk

# create vm
echo "\nCREATING $machine:"
VBoxManage createvm --name $machine --register

# configure vm
echo "\nMODIFYING $machine:"
VBoxManage modifyvm $machine \
--memory 2048 \
--ostype Ubuntu_64 \
--nic1 bridged \
--bridgeadapter1 "en1: Wi-Fi (AirPort)" \
--nictype1 82540EM \
--macaddress1 080027F9FA04

# setup shared clone folder
VBoxManage sharedfolder add $machine \
--name clone \
--hostpath /Developer/Atom/tate-clone

# setup shared data folder
VBoxManage sharedfolder add $machine \
--name Data \
--hostpath $machine_path/data

# setup shared git folder
VBoxManage sharedfolder add $machine \
--name git \
--hostpath /Developer/Atom

# setup shared machine folder
VBoxManage sharedfolder add $machine \
--name Machine \
--hostpath $machine_path

# setup shared repo folder
VBoxManage sharedfolder add $machine \
--name repo \
--hostpath /Developer/Atom/tate-repo

# setup shared vm folder
VBoxManage sharedfolder add $machine \
--name VM \
--hostpath $dir

# setup sata storage controller
VBoxManage storagectl $machine \
--name SATA \
--add sata \
--portcount 1

# setup sata storage
VBoxManage storageattach $machine \
--storagectl SATA \
--port 1 \
--device 0 \
--type hdd \
--medium $disk
echo "Done"

# remove logged ip
rm $machine_path/log/ip

# start vm
echo "\nSTARTING $machine:"
VBoxManage startvm $machine --type headless

# detect ip
printf "Waiting for IP..."
while [ ! -f "$machine_path/log/ip" ]; do
	printf "."
	sleep 1
done

# display new ip
echo "Got IP:"
cat $machine_path/log/ip

# update hosts file
echo "Updating hosts"
while read host; do
	echo "$(cat $machine_path/log/ip)	$host" >> /etc/hosts
done < $machine_path/hosts.ini

echo "\nDone\n"

exit
