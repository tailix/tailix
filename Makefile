CP      = cp
INSTALL = install
MKDIR   = mkdir
RM      = rm
SED     = sed

ARCH = x86_64

ABS_REPO != pwd
SYSROOT = $(ABS_REPO)/sysroot

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

$(SYSROOT)/etc/hosts: etc/hosts fhs
	$(INSTALL) -m 644 etc/hosts $(SYSROOT)/etc/hosts

$(SYSROOT)/etc/shells: etc/shells fhs
	$(INSTALL) -m 644 etc/shells $(SYSROOT)/etc/shells
