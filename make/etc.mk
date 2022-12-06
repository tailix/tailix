$(SYSROOT)/etc/hosts: etc/hosts
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/hosts $(SYSROOT)/etc/hosts

$(SYSROOT)/etc/shells: etc/shells
	$(INSTALL) -d $(SYSROOT)/etc
	$(INSTALL) -m 644 etc/shells $(SYSROOT)/etc/shells
