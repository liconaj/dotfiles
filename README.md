## Instalación base Arch Linux

1. **Conexión a internet**

   ~~~
   iwctl
   iwctl device list
   iwctl station stationname scan
   iwctl station stationname get-networks
   iwctl station stationname connect networkname
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

10. **Configurar zona horaria**

    ~~~
    ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
    hwclock --systohc
    nvim /etc/locale.gen 
    ~~~

    En `/etc/locale.gen` descomentar `#es_CO.UTF-8 UTF-8`  y luego ejecutar

    ~~~
    locale-gen
    echo "LANG=es_CO.UTF-8" >> /etc/locale.conf
    ~~~

11. **Nombre de equipo**

    Remmplazar `asus` con el nombre que tendrá su equipo, lo pongo así porque en mi portátil es marca ASUS

    ~~~
    echo "asus" > /etc/hostname
    nvim /etc/hosts
    ~~~

    Agregar lo siguiente a `/etc/hosts`

    ~~~
    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   asus.localdomain    asus
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
    useradd -mG wheel josue -c "Josué Licona Mármol"
    passwd josue
    EDITOR=nvim visudo
    ~~~

    Una vez dentro del archivo `sudoers.tmp` descomentamos el grupo `%wheel`

17. **Finalizar instalación**

    ~~~
    exit
    umount -a
    reboot
    ~~~

    

## Servidor gráfico y fuentes

Para conectarse a internet por medio de wi-fi se utiliza la herramienta `nmtui` para lo cual ejecutamos el comando

~~~
nmtui
~~~

Primero se instalará el gestor de paquetes para AUR, `yay`, el cual será útil más adelante.

~~~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd && sudo rm -r yay
~~~

Editar archivo `/etc/pacman.conf` y descomentamos las siguientes líneas

~~~
#[multilib]
#Include = /etc/pacman.d/mirrorlist
~~~

Al final del archivo agregamos el siguiente repositorio

~~~
[archlinuxfr]
SigLevel = Optional TrustAll
Server = http://repo.archlinux.fr/$arch
~~~

Para el gestor gráfico se instalarán los siguientes paquetes:

~~~
xorg  
xorg-server
xorg-xinit
xorg-server-xwayland
xf86-video-intel  
xf86-input-libinput  
~~~

Juntos con estos paquetes habrán de instalarse algunas fuentes no deseadas, procedermos a eliminarlas y a instalar otras mejores

~~~
sudo pacman -Rs xorg-fonts-75dpi xorg-fonts-100dpi
~~~

Para mejorar el renderizado de fuentes, que por lo general suele ser muy malo en esta distribución, habremos de instalar estos paquetes:

~~~
yay -S fontconfig-ubuntu cairo-ubuntu xsettingsd
~~~

Crear el archivo `~/.xsettingsd` y poner lo siguiente:

~~~
Xft/Hinting 1
Xft/HintStyle "hintslight"
Xft/Antialias 1
Xft/RGBA "rgb"
~~~

Crear arhivo `~/.config/fontconfig/fonts.conf` y poner la siguiente información:

~~~php+HTML
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <match target="font">
    	<edit mode="assign" name="hinting" >
    		<bool>true</bool>
    	</edit>
    	<edit mode="assign" name="autohint" >
    		<bool>false</bool>
    	</edit>
    	<edit mode="assign" name="hintstyle" >
    		<const>hintslight</const>
    	</edit>
    	<edit mode="assign" name="rgba" >
    		<const>rgb</const>
    	</edit>
    	<edit mode="assign" name="lcdfilter">
    		<const>lcddefault</const>
    	</edit>
    	<edit mode="assign" name="antialias" >
    		<bool>true</bool>
    	</edit>
    	<edit mode="assign" name="embeddedbitmap">
    		<bool>false</bool>
    		</edit>
    </match>

    <!-- Set preferred serif, sans serif, and monospace fonts. -->
    <alias>
    	<family>serif</family>
    	<prefer>
    		<family>Droid Serif</family>
    	</prefer>
    </alias>
    <alias>
    	<family>sans-serif</family>
    	<prefer>
    		<family>Droid Sans</family>
    	</prefer>
    </alias>
    <alias>
    	<family>sans</family>
    	<prefer>
    		<family>Droid Sans</family>
    	</prefer>
    </alias>
    <alias>
    	<family>monospace</family>
    	<prefer>
    		<family>Droid Sans Mono</family>
    	</prefer>
    </alias>
    <alias>
    	<family>mono</family>
    	<prefer>
    		<family>Droid Sans Mono</family>
    	</prefer>
    </alias>
</fontconfig>
~~~

Las fuentes a instalar pueden llegar a ser muchas, la manera más eficiente de hacer esto es creando un archivo `fonts.txt` con la lista de paquetes a instalar y con el comando `sudo pacman -S - < fonts.txt`

~~~
ttf-bitstream-vera
ttf-dejavu ttf-droid
gnu-free-fonts
ttf-ibm-plex 
ttf-liberation
ttf-linux-libertine
ttf-roboto
ttf-ubuntu-font-family
ttf-cascadia-code
ttf-fira-mono
ttf-fira-code
ttf-hack
ttf-jetbrains-mono
~~~

Existen algunas fuentes que no se encuentran en los repositorios oficiales, sino en AUR y se instalan a través de yay, estos son:

~~~
ttf-b612
ttf-courier-prime
ttf-envy-code-r 
ttf-inconsolata-g
ttf-iosevka
ttf-monaco
ttf-mononoki
ttf-anonymous-pro
ttf-inconsolata
font-victor-mono
~~~

## Escritorios

El escritorio que se instalará será Gnome junto Xfce4, ambos son muy compatibles ya que manejan librerías muy parecidas entre sí, por lo que no nos dará problemas. Aunque uso Gnome como mi escrtorio principal hay veces en que estes no es lo suficientemente óptimo y me da problemas, es aquí donde entra Xfce a salvarme el día y sacarme de apuros.

### Gnome

Para instalar el escritorio se instalarán los siguientes paquetes

~~~
gnome
gnome-extra
gnome-session-properties
~~~

Gnome instalará `gdm` como gestor de sesión, para habilitarlo ejecutamos `sudo systemctl enable gdm` 

El escritorio de Gnome tiende a ser uno de los más pesados, aunque a últimamente a mejorado su rendimiento se puede reducir su consumo haciendo los siguientes pasos:

- Para mostrar todos los servicios

  ~~~
  sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
  ~~~

- Abrimos la aplicación `gnome-session-properties` y desahibilitamos todos los servicios que consideremos innecesarios, yo solo dejo habilitados los siguientes y hasta el momento no he tenido problemas:

  ~~~
  AT-SPI D-Bus Bus
  Certificado y almacenamiento de claves
  GNOME color management
  GNOME keyboard configuration
  GNOME keyboard shortcuts
  GNOME power management
  GNOME XSettings
  Servicio de almacenamiento de secretos
  Sistema de Sonido de PulseAudio
  ~~~

- El servicio de evolution es uno de los que consume más recursos junto a gnome-software. El primero no es posible eliminarlo y desinstalarlo por completo fácilmente, pero podemos deshabilitarlo ejecutando  lo siguiente:

  ~~~
  sudo mv /usr/lib/evolution-data-server/ /usr/lib/evolution-data-server-disabled
  sudo mv /usr/lib/evolution /usr/lib/evolution-disabled
  sudo mv /usr/lib/evolution-calendar-factory /usr/lib/evolution-calendar-factory-disabled
  sudo mv /usr/lib/evolution-calendar-factory-subprocess /usr/lib/evolution-calendar-factory-subprocess-disabled
  ~~~

- Personalmente no utilizo la tienda de aplicaciones y creo que no funciona muy bien en Archlinux así que la desinstalo y de paso me ahorro unas megas de RAM con `sudo pacman -Rsnc gnome-software`

- Reduciendo la swappiness a 5 o 10 creando el archivo `/etc/sysctl.d/99-swappiness` y agregando `vm.swappiness=10`

Yo suelo ser muy cuidadoso con el estilo visual hasta en los pequeños, Gnome instala aplicaciones que no me son útiles y empañan el menú, así que las oculto agregando la opción `NoDisplay=true` al archivo de la aplicación `.desktop` dentro de la carpeta `/usr/share/applications/`. Las aplicaciones son:

~~~
accerciser
dconf-editor
avahi-discover
bssh
network-wired
ipython
gnome-nettool
gnome-control-center network
nvim
gnome-builder
redshift
redshift-gtk
htop
bvnc
qv4l2
glade 						# Diseñador de interfaces de usuario
ghex						# Editor hexadecimal
devhelp						# Documentación API
lstopo						# Mostrar topología del hardware
sysprof						# Perfil del sistema
xdvi						# dvi viewer
qvidcap						# Vista video captura
~~~

#### Extensiones

Para instalar extensiones a través `google-chrome-stable` necesitamos el paquete `chrome-gnome-shell`, las extensiones recomendadas son:

~~~
Desktop-icons
Dash to dock
ArcMenu
~~~

Para instalar `ArcMenu` ejecutamos lo siguiente, se puede instalar a través de la página pero por alguna razón no me funcionaba así que lo instalo  a través de la fuente:

~~~
git clone https://gitlab.com/arcmenu/ArcMenu.git
cd ArcMenu
make install
~~~

#### Gestos

Para habilitar el click con un toque ejecutamos:

~~~
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
~~~

Para habilitar los gestos del touchpad puede que nos haga falta el paquete `libinput-gestures` de AUR.



### Xfce

Los paquetes a instalar serían:

~~~
xfce4
xfce4-goodies
elementary-xfce-icons-git	(AUR)
xfce-theme-greybird-git		(AUR)
~~~

Este paquete viene con un montón de temas en `/usr/share/themes/` un poco viejos para mi gusto y que personalmente no uso, así que los elimino. Estos son:

~~~
Agua Adept Alternate AtlantaAtlanta2 B5 B6 Basix BBS Beastie Biz Blackwall Buzz Coldsteel Coolclean Cruxish Curve Daloa Default-4.0 Default-4.2 Default-4.4 Default-4.6 Default-4.8 Default-hdpi Default-xhdpi Defcon-IV Eazel-blue Elberg Exocet Fbx G2 Galaxy Gaudy Gelly Gnububble Gorilla Gtk Iceg Kde Kde1 Keramik Kindaker Kleanux Kokodi Koynacity Linea LineArt Meenee Metabox Microcurve Microdeck Microdeck2 Microdeck3 Microgui Mofit Moheli Next Ops Opta Oroborus Perl Pills Piranha Platinum Prune Quiet-purple Quinx R9X Redmond RedmondXP Sassandra Silverado Slick Slimline Smallscreen Smoothwall Stoneage Symphony Synthetic Tabs Tgc Tgc-large Therapy Today Totem Trench Tubular TUX Tyrex Variation Wallis Waza Wildbush Xfce Crux Greybird-compact Greybird-accessibility Greybird-dark Greybird-dark-acessibility Retro Triviality
~~~

Si no queremos que alguna de las aplicaciones  de Xfce no se muestren en otro escritorio agregamos y/o modificamos la siguiente línea:

~~~
NoShowIn=GNOME;		# Ejemplo
OnlyShowIn=XFCE;
~~~



## Aplicaciones

### Zsh

`sudo pacman -S zsh`

El shell que yo utilizo es zsh, este viene sin ninguna configuración por defecto, y para ahorrarme el tiempo yo uso `oh-my-zsh` con el siguiente comando:

~~~
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
~~~

El tema que yo utilizo es una personalización de `robbyrussell.zsh-theme` el cual he llamado `simple.zsh-theme`, este debe poner en la carpeta `~/.oh-my-zsh/themes` Un plugin muy útil es `zsh-autosuggestion` para instalarlo hacemos lo siguiente:

~~~
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
~~~



### Neovim

Neovim ya debiera encontrarse instalado en el sistema debido a que ya lo hicimos en el inicio, en dado caso que no lo haya hecho puedes instalarlo por medio de `sudo pacman -S neovim`. Algunos programas dependen de vim o de vi para funcionar, por eso se aconseja crear enlaces simbólicos en caso de ser requeridos y de paso podremos usar `vim` o `vi` para abrir archivos:

~~~
sudo ln -sf /bin/nvim /bin/vim
sudo ln -sf /bin/nvim /bin/vi
~~~

Para tener un editor más completo y poder instalar plugins se recomienda instalar estos complementos primero.

~~~
python -m pip install --user --upgrade pynvim
node install -g neovim
~~~

Para instalar vim-plug, gestor de plugins

~~~
sh -c 'curl -flo "${xdg_data_home:-$home/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \\
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
~~~

**Auto-pairs**

Para tener el fork mejorado de auto-pairs junto  a las opciones que tengo copie la carpeta `nvim/auto-pairs` en `~/.local/share/nvim/site/pack` 

**Configuración**

Para obtener mi configuración debe copiar el contenido de la  carpeta `nvim/configuraciones` dentro de `~/.config/nvim`



### Libreoffice

Para tener una suite más o menos completas recomiendo instalar estos paquetes, los que terminan en `fr` son para el idioma francés, instálalos si quieres.

~~~
libreoffice-fresh
libreoffice-fresh-es		# paquete de idioma
libreoffice-fresh-fr
hunspell 					# ortografía
hunspell-es_es
hunspell_es_any
hunspell_fr
hyphen						# reglas división de palabras
hyphen-es
hyphen-fr
mythes-es					# sinónimos
mythes-fr
languagetool				# gramática
libreoffice-extension-languagetool
languagetool-ngrams-es
languagetool-ngrams-fr
~~~



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
Ayu
Language - Spanish
SideBarEnhancements
Anaconda
~~~

Poner el contenido de la carpeta `Sublime-text/Configuraciones/` en `~/.config/sublime-text-3/Packages/User/` que son mis configuraciones.

### Spotify

El paquete `spotify` del AUR siempre me presenta problemas con GPG, podemos solucionarlo ejecutando esto primero:

~~~
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8FD3D9A8D3800305A9FFF259D1742AD60D811D58
~~~

### Emacs

En caso de que quieras usar emacs, te dejo mi configuración. El archivo `/Emacs/.pylintrc` va dentro de la carpeta `$HOME` esta es un archivo de configuración para el linter de python. Este requiere que instales `pylintrc` en emacs y en el sistema, también.                                                                                                                                                                                                          

### Otros aplicaciones y paquetes

~~~
cmatrix
neofetch
vlc
chrodpro-git (AUR)
spyder
audacity
kdenlive
typora (AUR)
textlive-most
texstudio
nodejs
redshift
inkscape
gthumb
simplescreenrecorder
exa
ntfs-3g
zoom (AUR)
~~~



## fstab

Yo tengo una partición de Windows y lo tengo configurado para que se monte automáticamente en el arranque en la carpeta `/windows`, debemos crearla primero y poner la siguiente línea en el archivo `/etc/fstab`

~~~
/dev/[partición] /windows ntfs-3g nosuid,nodev,nofail 0 0
# Otra manera es a través del UUID de la partiión este es único así que tendrías que mirar cual es el tuyo
UUID=F45A6CAA /windows ntfs-3g nosuid,nodev,nofail 0 0
~~~

