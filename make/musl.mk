dest/usr/lib/libc.a:
	mkdir -p build/musl
	cd build/musl && '../../vendor/musl/configure' --prefix=/usr
	$(MAKE) -C build/musl
	$(MAKE) -C build/musl DESTDIR='$(ABS_DEST)' install
