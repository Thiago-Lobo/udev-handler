#!/bin/bash

# Install exFAT support packages
apt remove --purge -y exfat-fuse

# Install NTFS support packages
apt remove --purge -y ntfs-3g

rm -r /var/log/udev-handler
