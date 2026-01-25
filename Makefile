
PREFIX?=/usr/local

.PHONY: test
test:
	bats --verbose-run test/test_*

.PHONY: dev-install
dev-install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	ln -sf $$PWD/kconfig-language-server $(DESTDIR)$(PREFIX)/bin/kconfig-language-server

.PHONY: install
install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 0755 kconfig-language-server $(DESTDIR)$(PREFIX)/bin/

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kconfig-language-server
