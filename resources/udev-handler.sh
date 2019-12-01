#!/bin/bash

echo "wrapper2: $(date) $1 $2" >> /tmp/test.txt

if [ $1 = "start" ]; then
	uuid=$(blkid | grep sda1 | perl -pe 's/.*?UUID="(.*?)".*/$1/')
	echo "will do start stuff" >> /tmp/test.txt
	mkdir /mnt/$2
	mount -o user,umask=0000 /dev/$2 /mnt/$2
fi

if [ $1 = "stop" ]; then
	echo "will do stop suff" >> /tmp/test.txt
	umount /mnt/$2
	rm -r /mnt/$2
fi

