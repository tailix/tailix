ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

DEST_BINS =\
	dest/bin/busybox
DEST_HEADERS = \
	dest/usr/include/kernaux.h
DEST_LIBS = \
	dest/usr/lib/libkernaux.la

all: fhs $(DEST_BINS) $(DEST_HEADERS) $(DEST_LIBS)

fhs:
	install -d dest/bin
	install -d dest/boot
	install -d dest/dev
	install -d dest/etc
	install -d dest/etc/opt
	install -d dest/home
	install -d dest/lib
	install -d dest/media
	install -d dest/mnt
	install -d dest/opt
	install -d dest/root
	install -d dest/run
	install -d dest/sbin
	install -d dest/srv
	install -d dest/tmp
	install -d dest/usr
	install -d dest/usr/bin
	install -d dest/usr/games
	install -d dest/usr/include
	install -d dest/usr/lib
	install -d dest/usr/libexec
	install -d dest/usr/local
	install -d dest/usr/local/bin
	install -d dest/usr/local/etc
	install -d dest/usr/local/games
	install -d dest/usr/local/include
	install -d dest/usr/local/lib
	install -d dest/usr/local/man
	install -d dest/usr/local/sbin
	install -d dest/usr/local/share
	install -d dest/usr/local/src
	install -d dest/usr/sbin
	install -d dest/usr/share
	install -d dest/usr/share/man
	install -d dest/usr/share/misc
	install -d dest/usr/src
	install -d dest/var
	install -d dest/var/cache
	install -d dest/var/lib
	install -d dest/var/lib/misc
	install -d dest/var/local
	install -d dest/var/lock
	install -d dest/var/log
	install -d dest/var/mail
	install -d dest/var/opt
	install -d dest/var/spool
	install -d dest/var/tmp
	ln -f -s /run dest/var/run

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
