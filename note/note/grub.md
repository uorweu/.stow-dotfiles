grub-efi install some how don't get to work and we have to manually config the through the commands inside the grub

- define what is the one that contain the operating system that we install by using "ls"
ls
ls (hd0,gpt3) 
and the command above show the file system is btrfs so i know for fact that my Linux partition
then we need to do these command to add this to the grub

insmod part_gpt
insmod btrfs

set root=(hd0,gpt3)

set prefix=(hd0,gpt3)/boot/grub

insmod normal
normal

now we can go to the operating system
after getting to the terminal do this to update it permantly

sudo update-grub
sudo grub-install /dev/sda


