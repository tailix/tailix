CP      = cp
GMAKE   = make
INSTALL = install
MKDIR   = mkdir
RM      = rm
SED     = sed

ARCH = x86_64

SRC != pwd
SYSROOT = $(SRC)/sysroot

SYSROOT_TARGETS = \
	$(SYSROOT)/bin/busybox           \
	$(SYSROOT)/etc/hosts             \
	$(SYSROOT)/etc/shells            \
	$(SYSROOT)/usr/include/kernaux.h \
	$(SYSROOT)/usr/lib/libc.a        \
	$(SYSROOT)/usr/lib/libkernaux.la

all: fhs $(SYSROOT_TARGETS)

clean:
	$(RM) -rf build $(SYSROOT) musl-gcc.specs

include make/busybox.mk
include make/fhs.mk
include make/libkernaux.mk
include make/musl.mk

run: image.iso
	qemu-system-x86_64 -m 2G -cdrom image.iso

image.iso: $(SYSROOT)/boot/grub/grub.cfg $(SYSROOT)/boot/bzImage all
	grub-mkrescue $(SYSROOT) -o image.iso

$(SYSROOT)/boot/grub/grub.cfg: boot/grub/grub.cfg fhs
	$(INSTALL) -d $(SYSROOT)/boot/grub
	cp boot/grub/grub.cfg $(SYSROOT)/boot/grub/grub.cfg

$(SYSROOT)/boot/bzImage: boot/bzImage fhs
	cp boot/bzImage $(SYSROOT)/boot/bzImage

$(SYSROOT)/etc/hosts: etc/hosts fhs
	$(INSTALL) -m 644 etc/hosts $(SYSROOT)/etc/hosts

$(SYSROOT)/etc/shells: etc/shells fhs
	$(INSTALL) -m 644 etc/shells $(SYSROOT)/etc/shells
