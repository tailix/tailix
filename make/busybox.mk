$(SYSROOT)/bin/busybox: build/busybox/busybox
	$(GMAKE) -C build/busybox install

build/busybox/busybox: build/busybox/.config $(SYSROOT)/usr/lib/libc.a
	$(SED) -i 's!^#ifdef __linux__$$!#ifdef NO_I_AM_NOT_LINUX!' $(SRC)/vendor/busybox/init/init.c
	$(GMAKE) -C build/busybox

build/busybox/.config: musl-gcc.specs
	$(MKDIR) -p build/busybox
	$(GMAKE) -C build/busybox -f $(SRC)/vendor/busybox/Makefile KBUILD_SRC=$(SRC)/vendor/busybox defconfig
	$(CP) build/busybox/.config build/busybox/.config.bak
	$(SED) -i 's!^#* *CONFIG_EXTRA_CFLAGS[ =].*$$!CONFIG_EXTRA_CFLAGS="-specs $(SRC)/musl-gcc.specs"!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PREFIX[ =].*$$!CONFIG_PREFIX="$(SYSROOT)"!'          build/busybox/.config
	#$(SED) -i 's!^#* *CONFIG_STATIC[ =].*$$!CONFIG_STATIC=y!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SYSROOT[ =].*$$!CONFIG_SYSROOT="$(SYSROOT)"!'        build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_WERROR[ =].*$$!CONFIG_WERROR=n!'                     build/busybox/.config
	# It's for Linux
	$(SED) -i 's!^#* *CONFIG_DEPMOD[ =].*$$!CONFIG_DEPMOD=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_INSMOD[ =].*$$!CONFIG_INSMOD=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LINUXRC[ =].*$$!CONFIG_LINUXRC=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LSMOD[ =].*$$!CONFIG_LSMOD=n!'                       build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MODINFO[ =].*$$!CONFIG_MODINFO=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MODPROBE[ =].*$$!CONFIG_MODPROBE=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SELINUX[ =].*$$!CONFIG_SELINUX=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SELINUXENABLED[ =].*$$!CONFIG_SELINUXENABLED=n!'     build/busybox/.config
	# Require Linux headers
	$(SED) -i 's!^#* *CONFIG_ACPID[ =].*$$!CONFIG_ACPID=n!'                       build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BEEP[ =].*$$!CONFIG_BEEP=n!'                         build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BLKDISCARD[ =].*$$!CONFIG_BLKDISCARD=n!'             build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BLOCKDEV[ =].*$$!CONFIG_BLOCKDEV=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BRCTL[ =].*$$!CONFIG_BRCTL=n!'                       build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_CONSPY[ =].*$$!CONFIG_CONSPY=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ETHER_WAKE[ =].*$$!CONFIG_ETHER_WAKE=n!'             build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FBSPLASH[ =].*$$!CONFIG_FBSPLASH=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_EJECT_SCSI[ =].*$$!CONFIG_FEATURE_EJECT_SCSI=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_IFCONFIG_SLIP[ =].*$$!CONFIG_FEATURE_IFCONFIG_SLIP=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MDEV_DAEMON[ =].*$$!CONFIG_FEATURE_MDEV_DAEMON=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MOUNT_LOOP[ =].*$$!CONFIG_FEATURE_MOUNT_LOOP=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_SETPRIV_CAPABILITIES[ =].*$$!CONFIG_FEATURE_SETPRIV_CAPABILITIES=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FSFREEZE[ =].*$$!CONFIG_FSFREEZE=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FSTRIM[ =].*$$!CONFIG_FSTRIM=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_HDPARM[ =].*$$!CONFIG_HDPARM=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CDETECT[ =].*$$!CONFIG_I2CDETECT=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CDUMP[ =].*$$!CONFIG_I2CDUMP=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CGET[ =].*$$!CONFIG_I2CGET=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CSET[ =].*$$!CONFIG_I2CSET=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CTRANSFER[ =].*$$!CONFIG_I2CTRANSFER=n!'           build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IFENSLAVE[ =].*$$!CONFIG_IFENSLAVE=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IONICE[ =].*$$!CONFIG_IONICE=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IP[ =].*$$!CONFIG_IP=n!'                             build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPADDR[ =].*$$!CONFIG_IPADDR=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPLINK[ =].*$$!CONFIG_IPLINK=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPNEIGH[ =].*$$!CONFIG_IPNEIGH=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPROUTE[ =].*$$!CONFIG_IPROUTE=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPRULE[ =].*$$!CONFIG_IPRULE=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPTUNNEL[ =].*$$!CONFIG_IPTUNNEL=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_KBD_MODE[ =].*$$!CONFIG_KBD_MODE=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LOADFONT[ =].*$$!CONFIG_LOADFONT=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LOSETUP[ =].*$$!CONFIG_LOSETUP=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MDEV[ =].*$$!CONFIG_MDEV=n!'                         build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKDOSFS[ =].*$$!CONFIG_MKDOSFS=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKE2FS[ =].*$$!CONFIG_MKE2FS=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_EXT2[ =].*$$!CONFIG_MKFS_EXT2=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_REISER[ =].*$$!CONFIG_MKFS_REISER=n!'           build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_VFAT[ =].*$$!CONFIG_MKFS_VFAT=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NAMEIF[ =].*$$!CONFIG_NAMEIF=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NANDDUMP[ =].*$$!CONFIG_NANDDUMP=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NANDWRITE[ =].*$$!CONFIG_NANDWRITE=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NBDCLIENT[ =].*$$!CONFIG_NBDCLIENT=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NSLOOKUP[ =].*$$!CONFIG_NSLOOKUP=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_OPENVT[ =].*$$!CONFIG_OPENVT=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PARTPROBE[ =].*$$!CONFIG_PARTPROBE=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RAIDAUTORUN[ =].*$$!CONFIG_RAIDAUTORUN=n!'           build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RUN_INIT[ =].*$$!CONFIG_RUN_INIT=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SEEDRNG[ =].*$$!CONFIG_SEEDRNG=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SETFONT[ =].*$$!CONFIG_SETFONT=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SLATTACH[ =].*$$!CONFIG_SLATTACH=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SHOWKEY[ =].*$$!CONFIG_SHOWKEY=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_TC[ =].*$$!CONFIG_TC=n!'                             build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_TUNCTL[ =].*$$!CONFIG_TUNCTL=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIATTACH[ =].*$$!CONFIG_UBIATTACH=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIDETACH[ =].*$$!CONFIG_UBIDETACH=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIMKVOL[ =].*$$!CONFIG_UBIMKVOL=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRENAME[ =].*$$!CONFIG_UBIRENAME=n!'               build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRMVOL[ =].*$$!CONFIG_UBIRMVOL=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRSVOL[ =].*$$!CONFIG_UBIRSVOL=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIUPDATEVOL[ =].*$$!CONFIG_UBIUPDATEVOL=n!'         build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UDHCPC[ =].*$$!CONFIG_UDHCPC=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UDHCPC6[ =].*$$!CONFIG_UDHCPC6=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UEVENT[ =].*$$!CONFIG_UEVENT=n!'                     build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_VI[ =].*$$!CONFIG_VI=n!'                             build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_VLOCK[ =].*$$!CONFIG_VLOCK=n!'                       build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_WATCHDOG[ =].*$$!CONFIG_WATCHDOG=n!'                 build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ZCIP[ =].*$$!CONFIG_ZCIP=n!'                         build/busybox/.config
	# Unnecessary programs
	$(SED) -i 's!^#* *CONFIG_HUSH[ =].*$$!CONFIG_HUSH=n!'                         build/busybox/.config
	# https://wiki.musl-libc.org/building-busybox.html
	$(SED) -i 's!^#* *CONFIG_EXTRA_COMPAT[ =].*$$!CONFIG_EXTRA_COMPAT=n!'         build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_INETD_RPC[ =].*$$!CONFIG_FEATURE_INETD_RPC=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MOUNT_NFS[ =].*$$!CONFIG_FEATURE_MOUNT_NFS=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_VI_REGEX_SEARCH[ =].*$$!CONFIG_FEATURE_VI_REGEX_SEARCH=n!' build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IFPLUGD[ =].*$$!CONFIG_IFPLUGD=n!'                   build/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PAM[ =].*$$!CONFIG_PAM=n!'                           build/busybox/.config
