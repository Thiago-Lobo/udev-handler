#!/bin/bash

LOG_PATH=/var/log/udev-handler
LOG_FILE=udev-handler.log

log_message()
{
	millis=$(python -c "from datetime import datetime;print datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]")
	echo "$millis $1" >> $LOG_PATH/$LOG_FILE
}

mkdir /var/log/udev-handler

# Install exFAT support packages
apt install -y exfat-fuse

# Install NTFS support packages
apt install -y ntfs-3g


