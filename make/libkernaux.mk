$(SYSROOT)/usr/include/kernaux.h: build/libkernaux/Makefile
	$(MAKE) -C build/libkernaux DESTDIR='$(SYSROOT)' install-data

$(SYSROOT)/usr/lib/libkernaux.la: build/libkernaux/Makefile
	$(MAKE) -C build/libkernaux DESTDIR='$(SYSROOT)' install-exec

build/libkernaux/Makefile: vendor/libkernaux/configure
	$(MKDIR) -p build/libkernaux
	cd build/libkernaux && '../../vendor/libkernaux/configure' --prefix=/usr

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
