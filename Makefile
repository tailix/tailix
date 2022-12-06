ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

DEST_TARGETS = \
	dest/bin/busybox           \
	dest/etc/hosts             \
	dest/etc/shells            \
	dest/usr/include/kernaux.h \
	dest/usr/lib/libc.a        \
	dest/usr/lib/libkernaux.la

all: fhs $(DEST_TARGETS)

include make/busybox.mk
include make/fhs.mk
include make/libkernaux.mk
include make/musl.mk

dest/etc/hosts: etc/hosts fhs
	install -m 644 etc/hosts dest/etc/hosts

dest/etc/shells: etc/shells fhs
	install -m 644 etc/shells dest/etc/shells
