dd if=/dev/zero of=/mnt/$1 bs=1G seek=10 count=0
docker run -v /mnt/$1:/mnt/$1 --privileged=true -t -i encrypted_container /bin/bash

#close cryptofs
cryptsetup luksClose $1

#remove crypto header from file
dd if=/dev/zero of=/mnt/$1 bs=1M count=10
#remove crypto file
rm /mnt/$1
#remove loopback mapping
losetup -a | grep $1 | cut -f1 -d":" | while read x; do losetup -d $x; done
