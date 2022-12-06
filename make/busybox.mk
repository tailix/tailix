dest/bin/busybox: build/busybox/busybox
	$(MAKE) -C build/busybox install

build/busybox/busybox: build/busybox/.config
	$(MAKE) -C build/busybox

build/busybox/.config:
	mkdir -p build/busybox
	$(MAKE) -C build/busybox -f $(ABS_REPO)/vendor/busybox/Makefile KBUILD_SRC=$(ABS_REPO)/vendor/busybox defconfig
	cp build/busybox/.config build/busybox/.config.bak
	sed -i 's!^#* *CONFIG_PREFIX[ =].*$$!CONFIG_PREFIX="$(ABS_REPO)/dest"!'                  build/busybox/.config
	sed -i 's!^#* *CONFIG_STATIC[ =].*$$!CONFIG_STATIC=y!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_WERROR[ =].*$$!CONFIG_WERROR=n!'                                   build/busybox/.config
	# It's for Linux
	sed -i 's!^#* *CONFIG_DEPMOD[ =].*$$!CONFIG_DEPMOD=n!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_INSMOD[ =].*$$!CONFIG_INSMOD=n!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_LINUXRC[ =].*$$!CONFIG_LINUXRC=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_LSMOD[ =].*$$!CONFIG_LSMOD=n!'                                     build/busybox/.config
	sed -i 's!^#* *CONFIG_MODINFO[ =].*$$!CONFIG_MODINFO=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_MODPROBE[ =].*$$!CONFIG_MODPROBE=n!'                               build/busybox/.config
	sed -i 's!^#* *CONFIG_SELINUX[ =].*$$!CONFIG_SELINUX=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_SELINUXENABLED[ =].*$$!CONFIG_SELINUXENABLED=n!'                   build/busybox/.config
	# Unnecessary programs
	sed -i 's!^#* *CONFIG_HUSH[ =].*$$!CONFIG_HUSH=n!'                                       build/busybox/.config
	# https://wiki.musl-libc.org/building-busybox.html
	sed -i 's!^#* *CONFIG_EXTRA_COMPAT[ =].*$$!CONFIG_EXTRA_COMPAT=n!'                       build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_INETD_RPC[ =].*$$!CONFIG_FEATURE_INETD_RPC=n!'             build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_MOUNT_NFS[ =].*$$!CONFIG_FEATURE_MOUNT_NFS=n!'             build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_VI_REGEX_SEARCH[ =].*$$!CONFIG_FEATURE_VI_REGEX_SEARCH=n!' build/busybox/.config
	sed -i 's!^#* *CONFIG_IFPLUGD[ =].*$$!CONFIG_IFPLUGD=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_PAM[ =].*$$!CONFIG_PAM=n!'                                         build/busybox/.config
