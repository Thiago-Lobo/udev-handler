#!/bin/bash

LOG_PATH=/var/log/udev-handler

log_message "RESOURCES_PATH is: $RESOURCES_PATH"

NAME_UNIT_SERVICE=udev-handler@.service
NAME_HANDLER_SCRIPT=udev-handler.sh
NAME_RULES_FILE=10-udev-handler.rules

DESTINATION_RULES_FILE=/etc/udev/rules.d
DESTINATION_UNIT_SERVICE=/etc/systemd/system
DESTINATION_HANDLER_SCRIPT=/etc/udev-handler

# Install exFAT support packages
apt remove --purge -y exfat-fuse

# Install NTFS support packages
apt remove --purge -y ntfs-3g

rm -r $LOG_PATH
rm -r $DESTINATION_HANDLER_SCRIPT

rm $DESTINATION_UNIT_SERVICE/$NAME_UNIT_SERVICE
rm $DESTINATION_RULES_FILE/$NAME_RULES_FILE

systemctl daemon-reload

udevadm control --reload-rules
