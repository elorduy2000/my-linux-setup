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
				- Posteriormente, y de manera opcionar se puede instalar _reflector_ para forzar cual mirrors se van a usar
		- Locales
			- es
		- Disk
			- Use best effort
			- File System: btrfs
			- Compression: yes
		- Bootloader
			- Gub
		- Profile
			- Minimal
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
		- Ingresar con el usuario definido en la instalacion
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
		sudo pacman -S lsd starship
		
		micro .bashrc
		# Configurar los siguientes parametros
		alias ls="lsd -la"
		alias tree="tree -C"
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
		GRUB_TIMEOUT=0
		GRUB_FORCE_HIDDEN_MENU="true"
		GRUB_BACKGROUND="~/Backgrounds/arch_linux_01.png"

		# Regenerar grub con los cambios
		sudo grub-mkconfig -o /etc/default/grub
		# sudo update-grub (en otras distros)

		sudo reboot now
		```
3. asds