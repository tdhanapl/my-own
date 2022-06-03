 ##scan the new hard disk
 $ ls /sys/class/scsi_host/ | while read host ; do echo "- - -"  > /sys/class/scsi_host/$host/scan ; done
 $ lsblk
 NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda             8:0    0   20G  0 disk
├─sda1          8:1    0    1G  0 part /boot
└─sda2          8:2    0   19G  0 part
  ├─rhel-root 253:0    0   17G  0 lvm  /
  └─rhel-swap 253:1    0    2G  0 lvm  [SWAP]
sdb             8:16   0    5G  0 disk
sr0            11:0    1 1024M  0 rom
##create lvm file system
 $ vgcreate rhel /dev/sdb1
$ vgcreate vg1 /dev/sdb1
##assgin full vg to logical voulme 
$lvcreate -l +100%FREE -n lv1 vg1
##assgin certain size from volume to logical voulme
$ lvcrate -L 1G -n lv1 vg1
##format file system
$mkfs.ext4 /dev/vg1/lv1
## mount lvm
$ mount /dev/vg1/lv1 /restore
##add some content in /restore
$ cd /restore
$ touch file
$ mkdir dhana
##unmount the file sys
$ umount /dev/vg1/lv1 
##go to archive location of lvms
$ cd /ect/lvm/archive
$  ll
$ vgcfgrestore --list
##restore the remove lvm
$ vgcfgrestore -f /etc/lvm/archive/vg1_0002-18736372631234.vg lv1
##scan lv
$ lvscan
here lv in incative 
##active lv 
$ lvchanage -ay /dev/vg1/lv1
$ lvscan
##check logical volume
$lvs
here display lvs of deleted 
##mount file system
$ mount /dev/vg1/lv1 /restore
###check the previous data
$ cd /restore
$ ll
here display previous data



