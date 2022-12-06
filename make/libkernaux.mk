dest/usr/include/kernaux.h: build/libkernaux/Makefile
	$(MAKE) -C build/libkernaux DESTDIR='$(ABS_DEST)' install-data

dest/usr/lib/libkernaux.la: build/libkernaux/Makefile
	$(MAKE) -C build/libkernaux DESTDIR='$(ABS_DEST)' install-exec

build/libkernaux/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux
	cd build/libkernaux && '../../../vendor/libkernaux/configure' --prefix=/usr

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
