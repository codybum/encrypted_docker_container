

#set root 
CRYPTFS_ROOT=/mnt
#find a unused loopback device
LOOP_DEVICE=$(losetup -f)
#mount our file on the loopback device
losetup $LOOP_DEVICE $CRYPTFS_ROOT/tmpfs.dat

#format cryptofs
printf "$1" | cryptsetup luksFormat $LOOP_DEVICE  -

#expose cryptofs
printf "$1" | cryptsetup luksOpen $LOOP_DEVICE cryptfs  -

#create local FS
mkfs.ext4 /dev/mapper/cryptfs

#create directory for local FS
mkdir -p /mnt/cryptfs

#mounts new fs under /mnt/cryptofs
mount /dev/mapper/cryptfs /mnt/cryptfs

