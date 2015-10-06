

#set root 
CRYPTFS_ROOT=/mnt
#find a unused loopback device
LOOP_DEVICE=$(losetup -f)
#mount our file on the loopback device
losetup $LOOP_DEVICE $CRYPTFS_ROOT/$1

#format cryptofs
printf "$2" | cryptsetup luksFormat $LOOP_DEVICE  -

#expose cryptofs
printf "$2" | cryptsetup luksOpen $LOOP_DEVICE $1  -

#create local FS
mkfs.ext4 /dev/mapper/$1

#create directory for local FS
mkdir -p /mnt/cryptfs

#mounts new fs under /mnt/cryptofs
mount /dev/mapper/$1 /mnt/cryptfs

