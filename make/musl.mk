musl-gcc.specs: dest/usr/lib/libc.a
	./musl-gcc.specs.sh $(ABS_REPO)/dest/usr/include $(ABS_REPO)/dest/usr/lib /lib/ld-musl-x86_64.so.1 > musl-gcc.specs

dest/usr/lib/libc.a:
	mkdir -p build/musl
	cd build/musl && '../../vendor/musl/configure' --prefix=/usr
	$(MAKE) -C build/musl
	$(MAKE) -C build/musl DESTDIR='$(ABS_DEST)' install
