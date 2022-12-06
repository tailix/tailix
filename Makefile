ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

all: dest/usr/include/kernaux.h dest/usr/lib/libkernaux.la dest/usr/lib/i386-elf/libkernaux.la dest/usr/lib/riscv64-elf/libkernaux.la dest/usr/lib/x86_64-elf/libkernaux.la

dest/usr/include/kernaux.h: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-data

dest/usr/lib/libkernaux.a dest/usr/lib/libkernaux.la: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/i386-elf/libkernaux.a dest/usr/lib/i386-elf/libkernaux.la: build/libkernaux/i386/Makefile
	$(MAKE) -C build/libkernaux/i386 DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/riscv64-elf/libkernaux.a dest/usr/lib/riscv64-elf/libkernaux.la: build/libkernaux/riscv64/Makefile
	$(MAKE) -C build/libkernaux/riscv64 DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/x86_64-elf/libkernaux.a dest/usr/lib/x86_64-elf/libkernaux.la: build/libkernaux/x86_64/Makefile
	$(MAKE) -C build/libkernaux/x86_64 DESTDIR='$(ABS_DEST)' install-exec

build/libkernaux/main/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/main
	cd build/libkernaux/main && '../../../$<' --prefix=/usr

build/libkernaux/i386/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/i386
	cd build/libkernaux/i386 && '../../../$<' \
		--host=i386-elf \
		--prefix=/usr \
		--libdir=/usr/lib/i386-elf \
		AR=i686-linux-gnu-ar \
		CC=i686-linux-gnu-gcc \
		RANLIB=i686-linux-gnu-ranlib

build/libkernaux/riscv64/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/riscv64
	cd build/libkernaux/riscv64 && '../../../$<' \
		--host=riscv64-elf \
		--prefix=/usr \
		--libdir=/usr/lib/riscv64-elf \
		AR=riscv64-linux-gnu-ar \
		CC=riscv64-linux-gnu-gcc \
		RANLIB=riscv64-linux-gnu-ranlib

build/libkernaux/x86_64/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/x86_64
	cd build/libkernaux/x86_64 && '../../../$<' \
		--host=x86_64-elf \
		--prefix=/usr \
		--libdir=/usr/lib/x86_64-elf \
		AR=x86_64-linux-gnu-ar \
		CC=x86_64-linux-gnu-gcc \
		RANLIB=x86_64-linux-gnu-ranlib

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
