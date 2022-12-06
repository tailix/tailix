ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

LIBSUBDIR_I386    = i386-elf
LIBSUBDIR_RISCV64 = riscv64-elf
LIBSUBDIR_X86_64  = x86_64-elf

DEST_HEADERS = \
	dest/usr/include/kernaux.h
DEST_LIBS = \
	dest/usr/lib/libkernaux.la \
	dest/usr/lib/$(LIBSUBDIR_I386)/libkernaux.la \
	dest/usr/lib/$(LIBSUBDIR_RISCV64)/libkernaux.la \
	dest/usr/lib/$(LIBSUBDIR_X86_64)/libkernaux.la

all: $(DEST_HEADERS) $(DEST_LIBS)

dest/usr/include/kernaux.h: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-data

dest/usr/lib/libkernaux.la: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/$(LIBSUBDIR_I386)/libkernaux.la: build/libkernaux/i386/Makefile
	$(MAKE) -C build/libkernaux/i386 DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/$(LIBSUBDIR_RISCV64)/libkernaux.la: build/libkernaux/riscv64/Makefile
	$(MAKE) -C build/libkernaux/riscv64 DESTDIR='$(ABS_DEST)' install-exec

dest/usr/lib/$(LIBSUBDIR_X86_64)/libkernaux.la: build/libkernaux/x86_64/Makefile
	$(MAKE) -C build/libkernaux/x86_64 DESTDIR='$(ABS_DEST)' install-exec

build/libkernaux/main/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/main
	cd build/libkernaux/main && '../../../vendor/libkernaux/configure' --prefix=/usr

build/libkernaux/i386/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/i386
	cd build/libkernaux/i386 && '../../../vendor/libkernaux/configure' \
		--host=i386-elf \
		--prefix=/usr \
		--libdir=/usr/lib/$(LIBSUBDIR_I386) \
		AR=i686-linux-gnu-ar \
		CC=i686-linux-gnu-gcc \
		RANLIB=i686-linux-gnu-ranlib

build/libkernaux/riscv64/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/riscv64
	cd build/libkernaux/riscv64 && '../../../vendor/libkernaux/configure' \
		--host=riscv64-elf \
		--prefix=/usr \
		--libdir=/usr/lib/$(LIBSUBDIR_RISCV64) \
		AR=riscv64-linux-gnu-ar \
		CC=riscv64-linux-gnu-gcc \
		RANLIB=riscv64-linux-gnu-ranlib

build/libkernaux/x86_64/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/x86_64
	cd build/libkernaux/x86_64 && '../../../vendor/libkernaux/configure' \
		--host=x86_64-elf \
		--prefix=/usr \
		--libdir=/usr/lib/$(LIBSUBDIR_X86_64) \
		AR=x86_64-linux-gnu-ar \
		CC=x86_64-linux-gnu-gcc \
		RANLIB=x86_64-linux-gnu-ranlib

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
