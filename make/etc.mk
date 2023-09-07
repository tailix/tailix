$(SYSROOT)/etc/group: etc/group
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/group $(SYSROOT)/etc/group

$(SYSROOT)/etc/hostname: etc/hostname
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/hostname $(SYSROOT)/etc/hostname

$(SYSROOT)/etc/hosts: etc/hosts
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/hosts $(SYSROOT)/etc/hosts

$(SYSROOT)/etc/inittab: etc/inittab
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/inittab $(SYSROOT)/etc/inittab

$(SYSROOT)/etc/passwd: etc/passwd
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/passwd $(SYSROOT)/etc/passwd

$(SYSROOT)/etc/shells: etc/shells
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/shells $(SYSROOT)/etc/shells
