#!/bin/bash

LOG_PATH=/var/log/udev-handler
LOG_FILE=udev-handler.log

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

upsert_directory $LOG_PATH

log_message "Determining WORKING_DIRECTORY..."

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
WORKING_DIRECTORY="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

log_message "WORKING_DIRECTORY is: $WORKING_DIRECTORY"

RESOURCES_PATH=$WORKING_DIRECTORY/resources

log_message "RESOURCES_PATH is: $RESOURCES_PATH"

NAME_UNIT_SERVICE=udev-handler@.service
NAME_ACTUATOR_SCRIPT=udev-handler-actuator.sh
NAME_RULES_FILE=10-udev-handler.rules
NAME_HANDLER_SCRIPT=udev-handler.py

DESTINATION_RULES_FILE=/etc/udev/rules.d
DESTINATION_UNIT_SERVICE=/etc/systemd/system
DESTINATION_SCRIPTS=/etc/udev-handler
DESTINATION_USER_CONFIG=/run/udev-handler

log_message "Installing exfat-fuse"

# Install exFAT support packages
apt install -y exfat-fuse

log_message "Installing ntfs-3g"

# Install NTFS support packages
apt install -y ntfs-3g

log_message "Upserting handler script destination: $DESTINATION_SCRIPTS"
upsert_directory $DESTINATION_SCRIPTS

log_message "Upserting user configuration directory: $DESTINATION_USER_CONFIG"
upsert_directory $DESTINATION_USER_CONFIG

log_message "Copying unit service to $DESTINATION_UNIT_SERVICE"
cp $RESOURCES_PATH/$NAME_UNIT_SERVICE $DESTINATION_UNIT_SERVICE

log_message "Copying rules file to $DESTINATION_RULES_FILE"
cp $RESOURCES_PATH/$NAME_RULES_FILE $DESTINATION_RULES_FILE

log_message "Copying actuator script to $DESTINATION_SCRIPTS"
cp $RESOURCES_PATH/$NAME_ACTUATOR_SCRIPT $DESTINATION_SCRIPTS

log_message "Copying handler script to $DESTINATION_SCRIPTS"
cp $RESOURCES_PATH/$NAME_HANDLER_SCRIPT $DESTINATION_SCRIPTS

log_message "Reloading udev rules"
udevadm control --reload-rules

log_message "Reloading systemd daemons"
systemctl daemon-reload
