ABS_REPO != pwd
ABS_DEST = $(ABS_REPO)/dest

DEST_BINS = \
	dest/bin/busybox
DEST_CONFIGS = \
	dest/etc/hosts \
	dest/etc/shells
DEST_HEADERS = \
	dest/usr/include/kernaux.h
DEST_LIBS = \
	dest/usr/lib/libkernaux.la

all: fhs $(DEST_BINS) $(DEST_CONFIGS) $(DEST_HEADERS) $(DEST_LIBS)

include make/busybox.mk
include make/fhs.mk
include make/libkernaux.mk

dest/etc/hosts: etc/hosts fhs
	install -m 644 etc/hosts dest/etc/hosts

dest/etc/shells: etc/shells fhs
	install -m 644 etc/shells dest/etc/shells
