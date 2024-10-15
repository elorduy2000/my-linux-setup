# ::: ARCH LINUX + HYPRLAND :::
### Paso a paso para instalar, configurar y personalizar Arch Linux con Hyprland

1. #### Instalar Arch Linux 
	- Referencias:
		- https://wiki.archlinux.org/title/Installation_guide
	- Crear una USB de arranque con el .iso de Arch Linux
		- https://archlinux.org/download/
		- https://www.ventoy.net/en/index.html
		- https://rufus.ie/en/
	- Inicie el PC desde la USB de arranque, y espere a que aparezca el prompt #
	- Ejecute el instalador con el siguiente comando:
		```sh
		archinstall
		```
	- En el menu seleccione las siguientes opciones:
		- Language
			- English
		- Mirrors
			- No seleccionar nada para que el instalador decida
usar
		- Locales
			- es
		- Disk
			- Use best effort
			- File System: btrfs
			- Compression: yes
		- Bootloader
			- Gub
		- Profile
			- Type
				- Hyperland
				- sddm
					intentar con ly sin desinstalarlo posteriormente
				- AMD open source
				- Polkitd
		- Audio
			- Pipewire
		- Additional packages
			- micro
		- network
			- Copy ISO
		- Timezone
			- America/Bogota
	- Instalar
		- Cuando termine reiniciar ejecutando el siguiente comando:
		```sh
		reboot now
		```
		- Cuando la pantalla se coloque en negro, retirar la USB
		- Esperar a que Arch Linux inicie y pida login
	- Desinstalar sddm
		- El servicio sddm solo se utilize para hacer una instalacion exitosa de Hyperland en Arch Linux, por lo tanto ahora podemos eliminarlo
		- Cambiarse a modo consola <_ctrl + alt +f(n)_>
		- Ingresar con el usuario definido en la instalacion
		- Eliminar sddm
			```sh
			sudo systemctl stop sddm
			sudo systemctl disable sddm
			sudo pacman -Rs sddm
			sudo reboot now
			```
2. #### Configuracion inicial
	- Referencias
		- https://wiki.archlinux.org/title/Pacman
		- https://wiki.archlinux.org/title/Archinstall
	- Configurar pacman y actualizar el sistema
		```sh
			sudo micro /etc/pacman.conf
			# Configurar los siguientes parametros
			Color
			ParallelDownloads = 8
			ILoveCandy

			sudo pacman -Syu
		```	
	- Establecer _terminus_ como la fuente por defecto para la la consola _xterm_
		- Referencias:
			- https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration
			- https://man.archlinux.org/man/vconsole.conf.5
		```sh
		ls /usr/shared/kbd/consolefonts/ter-*
		sudo pacman -S terminus-font
		ls /usr/shared/kbd/consolefonts/ter-*

		sudo micro /etc/vconsole.conf
		# Configurar los siguientes parametros
		KEYMAP=es 
		#KEYMAP=la-latin1
		FONT=ter-u22n
		
		# No esperar reinicio
		setfont ter-u22n
		```
		
	- Embellecer la consola
		- Referencias:
			- https://starship.rs/guide/
		```sh
		sudo pacman -S tree lsd starship reflector
		
		micro .bashrc
		# Configurar los siguientes parametros
		alias ls="lsd -la"
		alias tree="tree -C"
		alias refresh-mirrors="sudo reflector --verbose --ipv4 --protocols https --download-timeout 5 --score 10 --sort rate --save /etc/pacman.d/mirrorlist"
		# Agregar como ultima linea
		eval "$(starship init bash)"
		
		# refrescar los cambios
		source .bashrc
		``` 

	- Configurar Grub
		- Referencias:
			- https://wiki.archlinux.org/title/GRUB
			- https://wiki.archlinux.org/title/GRUB/Tips_and_tricks
			- https://bbs.archlinux.org/viewtopic.php?id=259604
			- https://archlinux.org/art/
		```sh
		# Descarga mis dotfiles y copia los backgrounds para poder usarlos en grub
		mkdir Downloads
		cd Downloads
		git clone https://github.com/my-linux-setup.git
		cd ..
		mkdir Backgrounds
		cp -r Downloads/my-linux-setup/Backgrounds/* Backgrounds/

		sudo micro `/etc/default/grub
		
		# Configurar los siguientes parametros
		GRUB_DEFAULT=0
		GRUB_TIMEOUT=0
		GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 splash"
		GRUB_TIMEOUT_STYLE="hidden"
		GRUB_BACKGROUND="/home/resilente/Backgrounds/arch_linux_01.png"

		# Regenerar grub con los cambios
		sudo grub-mkconfig -o /etc/default/grub
		# sudo update-grub (en otras distros)

		sudo reboot now
		```
	- Herramientas adicionales
		```sh
		sudo pacman -S fastfetch btop htop yazi fzf kitty
		``` 
3. #### Hyperland	
	- Ingresar a Hyperland con el siguiente comando:
		```sh
		Hyprland
		```
	- Configurar kitty
		- Referencias:
			- https://wiki.archlinux.org/title/Kitty
			- https://sw.kovidgoyal.net/kitty/kittens_intro/
			- https://sw.kovidgoyal.net/kitty/kittens/choose-fonts/
		- Copiar la configuracion de kitty
			```sh
			# Crear la carpeta de configuracion de kitty en caso que no exista
			ls .config/kitty
			mkdir .config/kitty

			cp /Downloads/my-linux-setup/dotfiles/kitty.conf /.conf/kitty
			```
	- Establecer wallpaper
		- Referencias:
			- https://builtin.com/articles/error-externally-managed-environment
			- https://wiki.archlinux.org/title/Hyprland#Desktop_wallpaper
			- https://github.com/LGFae/swww
			- https://hyprland.org/news/contestWinners/			
		-  Establecer el wallpaper en el arranque de Hyperland
			```sh		
			micro .config/hypr/hyprland.conf			
			# Agregar en la seccion AutoStart
			exec-once = swww-daemon
			exec-once = swww img /home/resilente/Wallpapers/00_current.jpg

			# Crea un comando simple (w) para randomizar el wallpaper desde la terminal
			micro .bashrc
			# Agrega el alias w
			alias w='/home/resilente/Scripts/randomize-wallpaper.sh'

			# Instalar python
			sudo pacman -S python
			
			# Instalar pywal 16 colors
			python3 -m venv ~/py_envs
			source ~/py_envs/bin/activate
			python3 -m pip install .			
			```
	- Configurar launcher
		- Referencias:
			- https://wiki.archlinux.org/title/Rofi
			- https://github.com/davatorium/rofi
			- https://github.com/newmanls/rofi-themes-collection
			- https://github.com/adi1090x/rofi
		- Instalar y configurar rofi para reemplazar wofi
			```sh
			sudo pacman -S rofi

			# Configurar rofi como menu de Hyperland
			micro .config/hypr/hyprland.conf
			# My Programs (comentar wofi)
			$menu = rofi -show drun -show-icons

			# Agregar otros temas
			cd Downloads
			git clone --depth=1 https://github.com/adi1090x/rofi.git
			cd rofi
			chmod +x setup.sh
			./setup.sh
			cd $HOME
			
			# Establece el tema type-2 style-1
			micro .config/rofi/config.rasi
			@theme "/home/resilente/.config/rofi/launchers/type-2/style-1.rasi"
			```
	- Configurar barra de estado
		- Referencias:
			https://github.com/Alexays/Waybar/wiki/Module:-Custom
		```sh
		# Instalar waybar
		sudo pacman -S waybar

		# Agregar usuario a grupo "input" para tener acceso al estado del teclado
		sudo usermod -aG input resilente
		# Hacer logout y login para que se reflejen los cambios		
		```
			
	- Configurar logout
		- Referencias:
			https://github.com/ArtsyMacaw/wlogout
			https://github.com/ArtsyMacaw/wlogout/blob/master/layout
			https://www.lorenzobettini.it/2024/02/hyprland-and-wlogout/
			https://github.com/mylinuxforwork/dotfiles/tree/main/share/dotfiles/.config/wlogout
		- Instalacion manual de wlogout
			```sh
			# Descargar, compilar e instalar wlogout
			cd Downloads
			git clone https://github.com/ArtsyMacaw/wlogout.git
			cd wlogout
			meson build
			ninja -C build
			sudo ninja -C build install
			```		

	- TODO: instalar y configurar firefox
		- Tema oscuro
			- GTK
		- Dark reader


TODO: configurar display manager

LY
	https://github.com/fairyglade/ly
sudo pacman -S ly (en caso que no funcione instalandolo desde archinstall)
	sudo systemctl enable ly
micro /etc/ly/config.ini
	animation = matrix
	fg = 5
	clock = %c
	numlock = true

SLICK
	https://github.com/linuxmint/slick-greeter
	https://wiki.archlinux.org/title/LightDM
	https://linuxgenie.net/install-configure-lightdm-display-manager-arch-linux/
	https://www.maketecheasier.com/customize-lightdm-themes/
	https://github.com/topics/lightdm-theme
	https://github.com/Xubuntu/lightdm-gtk-greeter-settings
	https://terminalroot.com/customize-lightdm-on-arch-linux/
	https://github.com/linuxmint/lightdm-settings
sudo pacman -S lightdm-slick-greeter



