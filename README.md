## Instalación base Arch Linux

Estos son los pasos que YO suelo seguir para instalar Arch Linux desde cero (cosa que hago muy seguido xD). Los dejo por aquí para tenerlos a la mano y porque quizás les pueden servir a alguien más como referencia. Debes tener ciertos conocimientos acerca de las instalaciones de Linux para poder entenderlo. Esto NO es un tutorial, son simplemente una lista de comandos y unos recursos para configurar el escritorio.

Estos comandos están basados en la guía que se puede encontrar en https://ermannoferrari.net que pertenece un Youtuber dedicado, especialmente, a tutoriales de ArchLinux, se los recomiendo.


1. **Conexión a internet**

   ~~~
   iwctl
   iwctl device list
   iwctl station stationname scan
   iwctl station stationname get-networks
   iwctl station stationname connect nombre_red
   ~~~

2. **Particionar disco**

   ~~~
   gdisk/[disk name] # (UEFI)
   cfdisk/[diskname] # (MBR)
   ~~~

3. **Formatear particiones**

   ~~~
   mkfs.fat -F32 /dev/[efi partition name] # (UEFI)
   mkfs.ext4 /dev/[root partiton name]
   mkswap /dev/[SWAP partition] 			# (MBR)
   swapon /dev/[SWAP partition] 			# (MBR)
   ~~~

4. **Montar particiones**

   ~~~
   mount /dev/[root partition name] /mnt
   mkdir /mnt/boot/efi 							# (UEFI)
   mount /dev/[efi partition name] /mnt/boot/efi 	# (UEFI)
   ~~~

5. **Instalación sistema base**

   ~~~
   pacstrap /mnt base linux linux-firmware nano neovim intel-ucode amd-ucode
   ~~~

6. **Generar File System Table (fstab)**

   ~~~
   genfstab -U /mnt >> /mnt/etc/fstab
   ~~~

7. **Entrar a la instalación como usuario root**

   ~~~
   arch-chroot /mnt
   ~~~

8. **Swapfile (UEFI)**

   ~~~
   dd if=/dev/zero of=/swapfile bs=1G count=2 status=progress
   chmod 600 /swapfile
   mkswap /swapfile
   swapon /swapfile
   ~~~

9. **Añadir swapfile a fstab (UEFI)**

   ~~~
   nvim /etc/fstab
   ~~~

   Agregar la siguiente línea a `fstab`

   ~~~
   /swapfile    none    swap    defaults    0 0
   ~~~

10. **Configurar zona horaria y distribución teclado**

    ~~~
    ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
    hwclock --systohc
    nvim /etc/locale.gen 
    ~~~
    Tienes que reemplazar la parte de `America/Bogota` por la de tu propia zona horaria.

    En `/etc/locale.gen` descomentar tu region, en mi caso es`#es_CO.UTF-8 UTF-8`, y luego ejecutar

    ~~~
    locale-gen
    echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
    ~~~
 
    Para cambiar la distribución de nuestro teclado de forma permanente en la consola tty usamos `echo KEYMAP=es_CO.UTF-8 > /etc/vconsole.conf`

11. **Nombre de equipo**

    Remmplazar `asus` con el nombre que tendrá su equipo, lo pongo así porque en mi portátil es marca ASUS

    ~~~
    echo "nombre_equipo" > /etc/hostname
    nvim /etc/hosts
    ~~~

    Agregar lo siguiente a `/etc/hosts`

    ~~~
    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   nombre_equipo.localdomain    nombre_equipo
    ~~~

12. **Contraseña usuario root**

    ~~~
    passwd
    ~~~

13. **Instalar el bootloader y otras utilidades**

    ~~~
    pacman -S grub efibootmgr networkmanager os-prober network-manager-applet dialog mtools dosfstools base-devel linux-headers bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth git xdg-utils xdg-user-dirs bash-completion
    ~~~

14. **Instalar GRUB**

    ~~~
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Archlinux 							 # (UEFI)
    grub-install --target=i386-pc /dev/[disk name]		# (MBR)
    os-prober
    ~~~

    `os-prober` es necesario en caso de que tengas instalado o vayas a instalar otro sistema operativo, como Windows, por ejemplo. En mi caso la resolución del grub nunca es la correcta por lo que tengo que corregirlo antes de crear el archivo de configuración por medio del archivo `/etc/default/grub`

    ~~~
    nvim /etc/default/grub
    ~~~

    Dentro del archivo editamos las siguientes variables con los valores dados

    ~~~
    GRUB_GFXMODE=1366x768,auto	# Cambiar la resolución
    # Si queremos que el GRUB recuerde el último sistema operativo al que se entró editamos estas opciones
    GRUN_DEFAULT=saved
    GRUB_SAVEDEFAULT="true"
    ~~~

    Después creamos el archivo de configuración del grub

    ~~~
    grub-mkconfig -o /boot/grub/grub.cfg
    ~~~

15. **Habilitar servicios**

    ~~~
    systemctl enable NetworkManager		# Internet
    systemctl enable bluetooth			# Bluetooth
    ~~~

16. **Agregar usuario administrador**

    ~~~
    useradd -mG wheel usuario -c "Nombre completo"
    passwd usuario
    EDITOR=nvim visudo
    ~~~

    Una vez dentro del archivo `sudoers.tmp` descomentamos el grupo `%wheel`

17. **Finalizar instalación**

    ~~~
    exit
    umount -a
    reboot
    ~~~

    
## Escritorio y personalización

El principal escritorio que uso es Xfce4, este escritorio requiere algunas configuraciones para dejarlo más decente. He desarrollado unos scripts para automatizar las configuraciones respectivas por medio de la instalación de todos los paquetes necesario y otros añadidos. No corras este script (`setup.sh`) a menos que sepas qué es lo que este hace, no me hago responsable de lo que este pueda hacer. Debes configurarlo según tus necesidades.


### Emacs

En caso de que quieras usar emacs, te dejo mi configuración. El archivo `RESOURCES/Emacs/.pylintrc` va dentro de la carpeta `$HOME` esta es un archivo de configuración para el linter de python. Este requiere que instales `pylintrc` en emacs y en el sistema, también.

### Sublime text

`sublime-text-3`

Licencias versión 3211

~~~
----- BEGIN LICENSE -----
Member J2TeaM
Single User License
EA7E-1011316
D7DA350E 1B8B0760 972F8B60 F3E64036
B9B4E234 F356F38F 0AD1E3B7 0E9C5FAD
FA0A2ABE 25F65BD8 D51458E5 3923CE80
87428428 79079A01 AA69F319 A1AF29A4
A684C2DC 0B1583D4 19CBD290 217618CD
5653E0A0 BACE3948 BB2EE45E 422D2C87
DD9AF44B 99C49590 D2DBDEE1 75860FD2
8C8BB2AD B2ECE5A4 EFC08AF2 25A9B864
------ END LICENSE ------
~~~

Otra forma es agregando las siguientes líneas al archivo `/etc/hosts` 

~~~
127.0.0.1 www.sublimetext.com
127.0.0.1 sublimetext.com
127.0.0.1 sublimehq.com
127.0.0.1 license.sublimehq.com
127.0.0.1 45.55.255.55
127.0.0.1 45.55.41.223
0.0.0.0 license.sublimehq.com
0.0.0.0 45.55.255.55
0.0.0.0 45.55.41.223
~~~

Y utilizar la  siguiente licencia:

~~~
----- BEGIN LICENSE -----
Member J2TeaM
Single User License
EA7E-1011316
D7DA350E 1B8B0760 972F8B60 F3E64036
B9B4E234 F356F38F 0AD1E3B7 0E9C5FAD
FA0A2ABE 25F65BD8 D51458E5 3923CE80
87428428 79079A01 AA69F319 A1AF29A4
A684C2DC 0B1583D4 19CBD290 217618CD
5653E0A0 BACE3948 BB2EE45E 422D2C87
DD9AF44B 99C49590 D2DBDEE1 75860FD2
8C8BB2AD B2ECE5A4 EFC08AF2 25A9B864
------ END LICENSE ------
~~~

Los paqutes que utilizo son:

~~~
A File Icon
Alignment
gruvbox
Language - Spanish
SideBarEnhancements
Anaconda
~~~


## fstab

Yo tengo una partición de Windows y lo tengo configurado para que se monte automáticamente en el arranque en la carpeta `/windows`, debemos crearla primero y poner la siguiente línea en el archivo `/etc/fstab`

~~~
/dev/[partición] /windows ntfs-3g nosuid,nodev,nofail 0 0
Otra manera es a través del UUID de la partiión este es único así que tendrías que mirar cual es el tuyo
UUID=F45A6CAA /windows ntfs-3g nosuid,nodev,nofail 0 0
~~~

## Eliminar instalación desde Windows en (UEFI)
Lo primero que se debe hacer es eliminar la partición de Linux y después se procederán a instalar los siguientes comandos en CMD como administrador
~~~
diskpart
sel disk 0
list part		# Listar particiones
sel part 1		# Partición EFI
assign letter z:
exit
bcdboot c:\windows /s z: /f uefi
bcdedit.exe /enum firmware
~~~
Buscar la entrada de la distribución y copiamos el número con letras que está entre corchetes, lo copiamos y lo pegamos en la parte del siguiente comando que está como `{}`
~~~
bcdedit.exe /delete {}
~~~

