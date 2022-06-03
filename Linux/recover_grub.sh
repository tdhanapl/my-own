#########recover grub file or corrupt grub file####
##first remove grub file
$ rm -rf /boot/grub2/grub.cfg
$ init 6
after reboot grub file corrupt
It prompt for grub>
grub>
#mount the iso os image 
grub>exit
#select troubleshooting
#select recuse mode
#it prompt 4 option
#select 1 for continue
#here dispaly after selecting 1 as chroot /mnt/sysimage
#now you chanage shell by below command
$ chroot /mnt/sysimage
it dispaly bash shell
bash-4.2#grub2-install /dev/sda #/dev/sda is /boot partition or other file system means we have mention that file system /boot present
bash-4.2# grub2-mkconfig -o /boot/grub2/grub.cfg
here display generating grub configuration file
bash-4.2#exit
sh-4.2#exit
After above step it sucessful load



 