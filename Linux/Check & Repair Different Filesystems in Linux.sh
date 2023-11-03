#####Check & Repair Different Filesystems in Linux | Ext2, Ext3, Ext4, XFS, ZFS Repair in Linux####

##FSCK stands for File System Consistency Check & most of the times, it runs at boot time but can also be started manually by super user, if need arises.
It can be used with 3 modes of operation;
1- Check for errors & let the user decide what should be done with each error.
2- Check for errors & make repairs automatically.
3- Check for errors & display the error but does not perform any repairs.

##We can use the FSCK command manually with the following syntax:
$ fsck options drives

The options that can be used with fsck command are,
-p      Automatic repair (no questions)
-n      Make no changes to the filesystem
-y      Assume “yes” to all questions
-c      Check for bad blocks and add them to the badblock list
-f      Force checking even if filesystem is marked clean
-v     Be verbose
-b     superblock Use alternative superblock
-B     blocksize Force blocksize when looking for superblock
-j      external_journal Set location of the external journal
-l      bad_blocks_file Add to badblocks list
-L     bad_blocks_file Set badblocks list

##We can use any of the following options, depending on the operation we need to perform. 
we must un-mount the drive with the following command,
$ umount drivename
e.g.
$ umount /dev/sdb

#You can check the partition number with the following command,
$ fdisk -l

Now let’s discuss usage of fsck command with examples,
##To perform a file check on a single partition, run the following command from the terminal,
$ umount /dev/sdc1
$ fsck /dev/sdc1
 
##Check filesystem for errors & repair them automatically
Run the fsck command with ‘a’ option to perform consistency check & to repair them automatically, execute the following command. We can also use ‘y’ option in place of option ‘a’.
$ fsck -a /dev/sdb1

##Check filesystem for errors but don’t repair them
In case we only need to see the error that are occurring on our file system & dont need to repair them, than we should run fsck with option ‘n’,
$ fsck -n /dev/sdb1

##Perform an error check on all partitions
To perform a filesystem check for all partitions in single go, use fsck with ‘A’ option, You can check all the filesystems in a single run of fsck using this option. This checks the file system in the order given by the fs_passno mentioned for each filesystem in /etc/fstab.
Please note that the filesystem with a fs_passno value of 0 are skipped, and greater than 0 are checked in the order.
The /etc/fstab contains the entries as listed below,

$ cat /etc/fstab
/dev/mapper/rhel-root   /                       xfs     defaults        0 0
UUID=91890bfd-31c5-44a1-b75a-3a3fe2de0e68 /boot                   xfs     defaults        0 0
/dev/mapper/rhel-swap   swap                    swap    defaults        0 0
/dev/sdb  /ext3_data  ext3  defaults 0 1
/dev/sdc1  /ext2_data  ext2  defaults  0 2
$/dev/sdc2  /xfs_data  xfs defaults 0 3

##Here, the filesystem with the same fs_passno are checked in parallel in your system.
$ fsck -A -y

##To disable the root file system check, we will use the option ‘R’
$ fsck -AR -y

##Check only partition with mentioned filesystem
In order to run fsck on all the partitions with mentioned filesystem type, for example ‘ext4’, use fsck with option ‘t’ followed by filesystem type,

$ fsck -t ext4 /dev/sdb1
or
$ fsck -t -A ext4

##Perform consistency check only on unmounted drives
##To make sure that the fsck is performed only on unmounted drives, we will use option ‘M’ while running fsck,
$ fsck -AM -y 

##Repair a XFS filesystem using xfs_repair
##The xfs_repair utility can be used to repair a corrupted or damaged XFS file system. The basic syntax used by xfs_repair is as follows:
$ xfs_repair /mount/point
$ xfs_repair /dev/sdc2

NOTE: Make sure you umount the XFS filesystem first before running the xfs_repair command.
Similar to the fsck utility, the xfs_repair utility fixes unmounted xfs filesystems in series of phases.
