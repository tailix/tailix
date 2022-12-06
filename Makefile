ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

dest/usr/include/kernaux.h: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-data

dest/usr/lib/libkernaux.a dest/usr/lib/libkernaux.la: build/libkernaux/main/Makefile
	$(MAKE) -C build/libkernaux/main DESTDIR='$(ABS_DEST)' install-exec

build/libkernaux/main/Makefile: vendor/libkernaux/configure
	mkdir -p build/libkernaux/main
	cd build/libkernaux/main && '../../../$<' --prefix=/usr

vendor/libkernaux/configure:
	cd vendor/libkernaux && ./autogen.sh
