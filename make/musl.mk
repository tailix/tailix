musl-gcc.specs: $(SYSROOT)/usr/lib/libc.a
	./musl-gcc.specs.sh $(SYSROOT)/usr/include $(SYSROOT)/usr/lib /lib/ld-musl-$(ARCH).so.1 > musl-gcc.specs

$(SYSROOT)/usr/lib/libc.a:
	$(MKDIR) -p build/musl
	cd build/musl && '../../vendor/musl/configure' --prefix=/usr
	$(GMAKE) -C build/musl
	$(GMAKE) -C build/musl DESTDIR='$(SYSROOT)' install
