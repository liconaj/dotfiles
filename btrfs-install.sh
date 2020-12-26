#!/bin/bash

# Mount partition
#ROOT=
#BOOT=

mount $ROOT /mnt

# Create subvolumes
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@swap
btrfs su cr /mnt/@.snapshots

# Mount subvolumes
umount /mnt
mount -o noatime,compress=lzo,space_cache,subvol=@ $ROOT /mnt
mkdir -p /mnt/boot/efi
mkdir /mnt/{home,var,opt,tmp,swap,.snapshots}
mount -o noatime,compress=lzo,space_cache,subvol=@home $ROOT /mnt/home
mount -o noatime,compress=lzo,space_cache,subvol=@tmp $ROOT /mnt/tmp
mount -o noatime,compress=lzo,space_cache,subvol=@opt $ROOT /mnt/opt
mount -o noatime,compress=lzo,space_cache,subvol=@.snapshots $ROOT /mnt/.snapshots
mount -o nodatacow,subvol=@swap $ROOT /mnt/swap
mount -o nodatacow,subvol=@var $ROOT /mnt/var
mount $BOOT /mnt/boot/efi

# Install base system
pacstrap /mnt base linux linux-firmware vim intel-ucode btrfs-progs

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt <<EOF

# Make swap
truncate -s 0 /swap/swapfile
chattr +C /swap/swapfile
btrfs property set /swap/swapfile compression none
dd if=/dev/zero of=/swap/swapfile bs=1G count=2 status=progress
chmod 600 /swap/swapfile
mkswap /swap/swapfile
echo "" >> /etc/fstab
echo "/swap/swapfile none swap defaults 0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc
sed -i -e 's/\#es_CO.UTF-8/es_CO.UTF-8/g' /etc/locale.gen

echo LANG=es_CO.UTF-8 >> /etc/locale.conf
echo KEYMAP=la-latin1 >> /etc/vconsole.conf
locale-gen

echo asus > /etc/hostname
echo "127.0.0.1        localhost" >> /etc/hosts
echo "::1              localhost" >> /etc/hosts
echo "127.0.1.1        asus.localdomain        asus" >> /etc/hosts

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet wpa_supplicant dialog os-prober mtools dosfstools base-devel linux-headers git bluez bluez-utils xdg-utils xdg-user-dirs alsa-utils pulseaudio pulseaudio-bluetooth --noconfirm

sed -i -e 's/MODULES=()/MODULES=(btrfs)/g' /etc/mkinitcpio.conf
mkinitcpio -p linux

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Archlinux
os-prober
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable bluetooth

EOF
clear
echo "Installation succesfully finished"
echo ""
echo "Set a password for root with 'passwd'"
echo "Create a new user with 'useradd -mG wheel username -c \"Real Name\"'"
echo "and set a password with 'passwd username'"
echo ""
echo "Don't forget to habilite wheel group in sudoers!"
echo ""
echo "Go out with 'exit', then umount all the partitions with 'umount -a'"
echo "and reboot"
arch-chroot /mnt
