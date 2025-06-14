
PREFIX?=/usr/local

.PHONY: test
test:
	bats --verbose-run test/test_*

.PHONY: dev-install
dev-install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	ln -sf $$PWD/kconfig-language-server $(DESTDIR)$(PREFIX)/bin/kconfig-language-server
	install -d $(DESTDIR)$(PREFIX)/share/kconfig-language-server/runtime
	install -m 0644 kconfig.spec $(DESTDIR)$(PREFIX)/share/kconfig-language-server/runtime/

.PHONY: install
install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 0755 kconfig-language-server $(DESTDIR)$(PREFIX)/bin/
	install -d $(DESTDIR)$(PREFIX)/share/kconfig-language-server/runtime
	install -m 0644 kconfig.spec $(DESTDIR)$(PREFIX)/share/kconfig-language-server/runtime/

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kconfig-language-server
	rm -f $(DESTDIR)$(PREFIX)/share/kconfig-language-server/runtime/kconfig.spec
