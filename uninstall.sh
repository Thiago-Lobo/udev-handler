#!/bin/bash

# Install exFAT support packages
sudo apt remove --purge -y exfat-fuse

# Install NTFS support packages
sudo apt remove --purge -y ntfs-3g

sudo rm -r /var/log/udev-handler
