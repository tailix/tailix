ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

DEST_BINS =\
	dest/bin/busybox
DEST_HEADERS = \
	dest/usr/include/kernaux.h
DEST_LIBS = \
	dest/usr/lib/libkernaux.la

all: $(DEST_BINS) $(DEST_HEADERS) $(DEST_LIBS)

dest/bin/busybox: build/busybox/busybox
	$(MAKE) -C build/busybox install

dest/usr/include/kernaux.h: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-data

dest/usr/lib/libkernaux.la: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-exec

build/busybox/.config:
	mkdir -p build/busybox
	$(MAKE) -C build/busybox -f $(ABS_REPO)/vendor/busybox/Makefile KBUILD_SRC=$(ABS_REPO)/vendor/busybox defconfig
	sed -i.bak 's!^#* *CONFIG_STATIC[^_].*$$!CONFIG_STATIC=y!'                  build/busybox/.config
	sed -i     's!^#* *CONFIG_PREFIX[^_].*$$!CONFIG_PREFIX="$(ABS_REPO)/dest"!' build/busybox/.config
	sed -i     's!^#* *CONFIG_LINUXRC[^_].*$$!CONFIG_LINUXRC=n!'                build/busybox/.config
	sed -i     's!^#* *CONFIG_DEPMOD[^_].*$$!CONFIG_DEPMOD=n!'                  build/busybox/.config
	sed -i     's!^#* *CONFIG_INSMOD[^_].*$$!CONFIG_INSMOD=n!'                  build/busybox/.config
	sed -i     's!^#* *CONFIG_LSMOD[^_].*$$!CONFIG_LSMOD=n!'                    build/busybox/.config
	sed -i     's!^#* *CONFIG_MODINFO[^_].*$$!CONFIG_MODINFO=n!'                build/busybox/.config
	sed -i     's!^#* *CONFIG_MODPROBE[^_].*$$!CONFIG_MODPROBE=n!'              build/busybox/.config

build/busybox/busybox: build/busybox/.config
	$(MAKE) -C build/busybox

build/libkernaux/main/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/main
	cd build/libkernaux/main && '../../../vendor/libkernaux/configure' --prefix=/usr

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
