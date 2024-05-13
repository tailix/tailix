$(SYSROOT)/bin/busybox: $(BUILDDIR)/busybox/busybox
	$(GMAKE) -C $(BUILDDIR)/busybox install

$(BUILDDIR)/busybox/busybox: $(BUILDDIR)/busybox/.config $(SYSROOT)/usr/lib/libc.a
	$(SED) -i 's!^#ifdef __linux__$$!#ifdef NO_I_AM_NOT_LINUX!' $(SRC)/vendor/busybox/init/init.c
	$(GMAKE) -C $(BUILDDIR)/busybox

$(BUILDDIR)/busybox/.config: musl-gcc.specs
	$(MKDIR) -p $(BUILDDIR)/busybox
	$(GMAKE) -C $(BUILDDIR)/busybox -f $(SRC)/vendor/busybox/Makefile KBUILD_SRC=$(SRC)/vendor/busybox defconfig
	$(CP) $(BUILDDIR)/busybox/.config $(BUILDDIR)/busybox/.config.bak
	$(SED) -i 's!^#* *CONFIG_EXTRA_CFLAGS[ =].*$$!CONFIG_EXTRA_CFLAGS="-specs $(SRC)/musl-gcc.specs"!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PREFIX[ =].*$$!CONFIG_PREFIX="$(SYSROOT)"!'          $(BUILDDIR)/busybox/.config
	#$(SED) -i 's!^#* *CONFIG_STATIC[ =].*$$!CONFIG_STATIC=y!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SYSROOT[ =].*$$!CONFIG_SYSROOT="$(SYSROOT)"!'        $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_WERROR[ =].*$$!CONFIG_WERROR=n!'                     $(BUILDDIR)/busybox/.config
	#
	# https://wiki.musl-libc.org/building-busybox.html
	#
	$(SED) -i 's!^#* *CONFIG_EXTRA_COMPAT[ =].*$$!CONFIG_EXTRA_COMPAT=n!'         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_INETD_RPC[ =].*$$!CONFIG_FEATURE_INETD_RPC=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MOUNT_NFS[ =].*$$!CONFIG_FEATURE_MOUNT_NFS=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_VI_REGEX_SEARCH[ =].*$$!CONFIG_FEATURE_VI_REGEX_SEARCH=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IFPLUGD[ =].*$$!CONFIG_IFPLUGD=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PAM[ =].*$$!CONFIG_PAM=n!'                           $(BUILDDIR)/busybox/.config
	#
	# Direct use of /etc/passwd, /etc/group, /etc/shadow
	#
	$(SED) -i 's!^#* *CONFIG_USE_BB_PWD_GRP[ =].*$$!CONFIG_USE_BB_PWD_GRP=y!'     $(BUILDDIR)/busybox/.config
	#
	# Unnecessary programs: nonstandard
	#
	$(SED) -i 's!^#* *CONFIG_ADD_SHELL[ =].*$$!CONFIG_ADD_SHELL=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BOOTCHARTD[ =].*$$!CONFIG_BOOTCHARTD=n!'             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_CTTYHACK[ =].*$$!CONFIG_CTTYHACK=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_DEVMEM[ =].*$$!CONFIG_DEVMEM=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_DNSD[ =].*$$!CONFIG_DNSD=n!'                         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_DPKG[ =].*$$!CONFIG_DPKG=n!'                         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_DPKG_DEB[ =].*$$!CONFIG_DPKG_DEB=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_HUSH[ =].*$$!CONFIG_HUSH=n!'                         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PIPE_PROGRESS[ =].*$$!CONFIG_PIPE_PROGRESS=n!'       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_REMOVE_SHELL[ =].*$$!CONFIG_REMOVE_SHELL=n!'         $(BUILDDIR)/busybox/.config
	#
	# Unnecessary programs: runit init system
	#
	$(SED) -i 's!^#* *CONFIG_CHPST[ =].*$$!CONFIG_CHPST=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ENVDIR[ =].*$$!CONFIG_ENVDIR=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ENVUIDGID[ =].*$$!CONFIG_ENVUIDGID=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RUNSV[ =].*$$!CONFIG_RUNSV=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RUNSVDIR[ =].*$$!CONFIG_RUNSVDIR=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SETUIDGID[ =].*$$!CONFIG_SETUIDGID=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SOFTLIMIT[ =].*$$!CONFIG_SOFTLIMIT=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SV[ =].*$$!CONFIG_SV=n!'                             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SVC[ =].*$$!CONFIG_SVC=n!'                           $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SVLOGD[ =].*$$!CONFIG_SVLOGD=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SVOK[ =].*$$!CONFIG_SVOK=n!'                         $(BUILDDIR)/busybox/.config
	#
	# Unnecessary programs: are they for Linux?
	#
	$(SED) -i 's!^#* *CONFIG_FDFLUSH[ =].*$$!CONFIG_FDFLUSH=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FREERAMDISK[ =].*$$!CONFIG_FREERAMDISK=n!'           $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PIVOT_ROOT[ =].*$$!CONFIG_PIVOT_ROOT=n!'             $(BUILDDIR)/busybox/.config
	#
	# It's for Linux, we are not Linux
	#
	$(SED) -i 's!^#* *CONFIG_DEPMOD[ =].*$$!CONFIG_DEPMOD=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_INSMOD[ =].*$$!CONFIG_INSMOD=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LINUXRC[ =].*$$!CONFIG_LINUXRC=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LSMOD[ =].*$$!CONFIG_LSMOD=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MODINFO[ =].*$$!CONFIG_MODINFO=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MODPROBE[ =].*$$!CONFIG_MODPROBE=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RMMOD[ =].*$$!CONFIG_RMMOD=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SELINUX[ =].*$$!CONFIG_SELINUX=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SELINUXENABLED[ =].*$$!CONFIG_SELINUXENABLED=n!'     $(BUILDDIR)/busybox/.config
	#
	# Require Linux headers
	#
	$(SED) -i 's!^#* *CONFIG_ACPID[ =].*$$!CONFIG_ACPID=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BEEP[ =].*$$!CONFIG_BEEP=n!'                         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BLKDISCARD[ =].*$$!CONFIG_BLKDISCARD=n!'             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BLOCKDEV[ =].*$$!CONFIG_BLOCKDEV=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_BRCTL[ =].*$$!CONFIG_BRCTL=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_CONSPY[ =].*$$!CONFIG_CONSPY=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ETHER_WAKE[ =].*$$!CONFIG_ETHER_WAKE=n!'             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FBSPLASH[ =].*$$!CONFIG_FBSPLASH=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_EJECT_SCSI[ =].*$$!CONFIG_FEATURE_EJECT_SCSI=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_IFCONFIG_SLIP[ =].*$$!CONFIG_FEATURE_IFCONFIG_SLIP=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MDEV_DAEMON[ =].*$$!CONFIG_FEATURE_MDEV_DAEMON=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_MOUNT_LOOP[ =].*$$!CONFIG_FEATURE_MOUNT_LOOP=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FEATURE_SETPRIV_CAPABILITIES[ =].*$$!CONFIG_FEATURE_SETPRIV_CAPABILITIES=n!' $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FSFREEZE[ =].*$$!CONFIG_FSFREEZE=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_FSTRIM[ =].*$$!CONFIG_FSTRIM=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_HDPARM[ =].*$$!CONFIG_HDPARM=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CDETECT[ =].*$$!CONFIG_I2CDETECT=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CDUMP[ =].*$$!CONFIG_I2CDUMP=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CGET[ =].*$$!CONFIG_I2CGET=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CSET[ =].*$$!CONFIG_I2CSET=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_I2CTRANSFER[ =].*$$!CONFIG_I2CTRANSFER=n!'           $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IFENSLAVE[ =].*$$!CONFIG_IFENSLAVE=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IONICE[ =].*$$!CONFIG_IONICE=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IP[ =].*$$!CONFIG_IP=n!'                             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPADDR[ =].*$$!CONFIG_IPADDR=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPLINK[ =].*$$!CONFIG_IPLINK=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPNEIGH[ =].*$$!CONFIG_IPNEIGH=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPROUTE[ =].*$$!CONFIG_IPROUTE=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPRULE[ =].*$$!CONFIG_IPRULE=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_IPTUNNEL[ =].*$$!CONFIG_IPTUNNEL=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_KBD_MODE[ =].*$$!CONFIG_KBD_MODE=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LOADFONT[ =].*$$!CONFIG_LOADFONT=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_LOSETUP[ =].*$$!CONFIG_LOSETUP=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MDEV[ =].*$$!CONFIG_MDEV=n!'                         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKDOSFS[ =].*$$!CONFIG_MKDOSFS=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKE2FS[ =].*$$!CONFIG_MKE2FS=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_EXT2[ =].*$$!CONFIG_MKFS_EXT2=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_REISER[ =].*$$!CONFIG_MKFS_REISER=n!'           $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_MKFS_VFAT[ =].*$$!CONFIG_MKFS_VFAT=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NAMEIF[ =].*$$!CONFIG_NAMEIF=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NANDDUMP[ =].*$$!CONFIG_NANDDUMP=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NANDWRITE[ =].*$$!CONFIG_NANDWRITE=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NBDCLIENT[ =].*$$!CONFIG_NBDCLIENT=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_NSLOOKUP[ =].*$$!CONFIG_NSLOOKUP=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_OPENVT[ =].*$$!CONFIG_OPENVT=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_PARTPROBE[ =].*$$!CONFIG_PARTPROBE=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RAIDAUTORUN[ =].*$$!CONFIG_RAIDAUTORUN=n!'           $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_RUN_INIT[ =].*$$!CONFIG_RUN_INIT=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SEEDRNG[ =].*$$!CONFIG_SEEDRNG=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SETFONT[ =].*$$!CONFIG_SETFONT=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SLATTACH[ =].*$$!CONFIG_SLATTACH=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_SHOWKEY[ =].*$$!CONFIG_SHOWKEY=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_TC[ =].*$$!CONFIG_TC=n!'                             $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_TUNCTL[ =].*$$!CONFIG_TUNCTL=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIATTACH[ =].*$$!CONFIG_UBIATTACH=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIDETACH[ =].*$$!CONFIG_UBIDETACH=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIMKVOL[ =].*$$!CONFIG_UBIMKVOL=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRENAME[ =].*$$!CONFIG_UBIRENAME=n!'               $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRMVOL[ =].*$$!CONFIG_UBIRMVOL=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIRSVOL[ =].*$$!CONFIG_UBIRSVOL=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UBIUPDATEVOL[ =].*$$!CONFIG_UBIUPDATEVOL=n!'         $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UDHCPC[ =].*$$!CONFIG_UDHCPC=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UDHCPC6[ =].*$$!CONFIG_UDHCPC6=n!'                   $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_UEVENT[ =].*$$!CONFIG_UEVENT=n!'                     $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_VLOCK[ =].*$$!CONFIG_VLOCK=n!'                       $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_WATCHDOG[ =].*$$!CONFIG_WATCHDOG=n!'                 $(BUILDDIR)/busybox/.config
	$(SED) -i 's!^#* *CONFIG_ZCIP[ =].*$$!CONFIG_ZCIP=n!'                         $(BUILDDIR)/busybox/.config
