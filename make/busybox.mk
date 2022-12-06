dest/bin/busybox: build/busybox/busybox
	$(MAKE) -C build/busybox install

build/busybox/busybox: build/busybox/.config
	$(MAKE) -C build/busybox

build/busybox/.config:
	mkdir -p build/busybox
	$(MAKE) -C build/busybox -f $(ABS_REPO)/vendor/busybox/Makefile KBUILD_SRC=$(ABS_REPO)/vendor/busybox defconfig
	cp build/busybox/.config build/busybox/.config.bak
	sed -i 's!^#* *CONFIG_PREFIX[^_].*$$!CONFIG_PREFIX="$(ABS_REPO)/dest"!'                  build/busybox/.config
	sed -i 's!^#* *CONFIG_STATIC[^_].*$$!CONFIG_STATIC=y!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_WERROR[^_].*$$!CONFIG_WERROR=n!'                                   build/busybox/.config
	# It's for Linux
	sed -i 's!^#* *CONFIG_DEPMOD[^_].*$$!CONFIG_DEPMOD=n!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_INSMOD[^_].*$$!CONFIG_INSMOD=n!'                                   build/busybox/.config
	sed -i 's!^#* *CONFIG_LINUXRC[^_].*$$!CONFIG_LINUXRC=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_LSMOD[^_].*$$!CONFIG_LSMOD=n!'                                     build/busybox/.config
	sed -i 's!^#* *CONFIG_MODINFO[^_].*$$!CONFIG_MODINFO=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_MODPROBE[^_].*$$!CONFIG_MODPROBE=n!'                               build/busybox/.config
	sed -i 's!^#* *CONFIG_SELINUX[^_].*$$!CONFIG_SELINUX=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_SELINUXENABLED[^_].*$$!CONFIG_SELINUXENABLED=n!'                   build/busybox/.config
	# Unnecessary programs
	sed -i 's!^#* *CONFIG_HUSH[^_].*$$!CONFIG_HUSH=n!'                                       build/busybox/.config
	# https://wiki.musl-libc.org/building-busybox.html
	sed -i 's!^#* *CONFIG_EXTRA_COMPAT[^_].*$$!CONFIG_EXTRA_COMPAT=n!'                       build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_INETD_RPC[^_].*$$!CONFIG_FEATURE_INETD_RPC=n!'             build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_MOUNT_NFS[^_].*$$!CONFIG_FEATURE_MOUNT_NFS=n!'             build/busybox/.config
	sed -i 's!^#* *CONFIG_FEATURE_VI_REGEX_SEARCH[^_].*$$!CONFIG_FEATURE_VI_REGEX_SEARCH=n!' build/busybox/.config
	sed -i 's!^#* *CONFIG_IFPLUGD[^_].*$$!CONFIG_IFPLUGD=n!'                                 build/busybox/.config
	sed -i 's!^#* *CONFIG_PAM[^_].*$$!CONFIG_PAM=n!'                                         build/busybox/.config
