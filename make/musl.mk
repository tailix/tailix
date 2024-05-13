musl-gcc.specs: $(SYSROOT)/usr/lib/libc.a
	$(SCRIPTS)/musl-gcc.specs.sh $(SYSROOT)/usr/include $(SYSROOT)/usr/lib /lib/ld-musl-$(ARCH).so.1 > musl-gcc.specs

$(SYSROOT)/usr/lib/libc.a:
	$(MKDIR) -p $(BUILDDIR)/musl
	cd $(BUILDDIR)/musl && '../../vendor/musl/configure' --prefix=/usr
	$(GMAKE) -C $(BUILDDIR)/musl
	$(GMAKE) -C $(BUILDDIR)/musl DESTDIR='$(SYSROOT)' install
