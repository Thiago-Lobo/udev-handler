#!/usr/bin/python

import sys
import os

def print_usage_and_exit():
	print '\nUsage: udev-handler [-l] [-a "[label]" [mount_name]] [-r [mount_name]] [-u [mount_name]|[mount_path]]\n'
	print '  -l:\t\t\t\tlist current mappings'
	print '  -a "[label]" [mount_name]:\tadd a new mapping for volumes with label "[label]" to be mapped to /mnt/[mount_name]'
	print '  -r [mount_name]: list current mappings'
	print '  -u [mount_name]|[mount_path]: list current mappings'
	print '\nUse "sudo blkid" to find the label of your volume.\n'
	sys.exit(0)

def handle_arguments():
	return 1

def main():
	print_usage_and_exit()

if __name__ == '__main__':
	main()
