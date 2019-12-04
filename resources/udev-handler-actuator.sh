#!/bin/bash

LOG_PATH=/var/log/udev-handler
LOG_FILE=udev-handler.log

MOUNT_ROOT=/mnt

log_message()
{
	millis=$(python -c "from datetime import datetime;print datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]")
	echo "$millis $1" >> $LOG_PATH/$LOG_FILE
}

upsert_directory()
{
	if [ ! -d $1 ]; then
		mkdir $1
	fi
}

log_message "udev-handler.sh was called with [$1] and [$2]"

if [ $1 = "start" ]; then
	uuid=$(blkid | grep $2 | perl -pe 's/.*?UUID="(.*?)".*/$1/')
	log_message "Device UUID is: $uuid"

	mount_directory=$MOUNT_ROOT/$2
	upsert_directory $mount_directory
	log_message "Upserted mount directory: $mount_directory"

	mount -o user,umask=0000 /dev/$2 $mount_directory
	log_message "Mounted /dev/$2 on $mount_directory"
fi

if [ $1 = "stop" ]; then
	mount_directory=$MOUNT_ROOT/$2
	umount $mount_directory

	log_message "Unmounted $mount_directory"
	# rm -r /mnt/$2
fi
