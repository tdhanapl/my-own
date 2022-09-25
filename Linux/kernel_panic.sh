Kernel Panic Error Resolution of  initramfs image is missing or corrupted in RHEL 7/8:
--------------------------------------------------------------------
1. See the details of Kernel Panic Error (Identify the reason behind it eg. New Kernel, Corrupted initramfs, New Packages after Patching, Hardware change etc.)

2. Login the system with root credentials through rescue mode.

3. Take necesarry action as the reason of getting this error.
If it is due to new kernel, then downgrade it.
If it is due to corrupted or missing initramfs, regenerate it.

4. In our case it is due to corrupted/absent initramfs file. First check your kernel version.
# uname -r
5.After get kernel panic reboot the server
select recuse mode
it will boot recuse mode and we able access the server

6. Now regenerate initramfs with dracut or mkinitrd command: (here your kernel version should be same as in previous command result)
To create new initramfs use:
#dracut initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR
# mkinitrd initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64

To replace exsiting initramfs file use:
# dracut -f initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR
# mkinitrd --force initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
7.After replace  exsiting or regenerate initramfs file reboot server
$ init 6
after reboot sucessful server up
