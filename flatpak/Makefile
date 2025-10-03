PREFIX ?= /app
APP_VERSION ?= <unreleased>
FLATPAK_ID ?= io.github.DamnedAngel.msx-tile-forge
SRCDIR ?= ..
DESTDIR ?= 

.PHONY: all

all:
	# Replace version placeholders
	find . -type f -name "$(SRCDIR)/*.py" -exec sed -i "s/<unreleased>/$(APP_VERSION)/g" {} +

	# Install Python scripts
	install -Dm644 $(SRCDIR)/msxtileforge.py       $(DESTDIR)$(PREFIX)/bin/msxtileforge.py
	install -Dm644 $(SRCDIR)/msxtileexport.py      $(DESTDIR)$(PREFIX)/bin/msxtileexport.py
	install -Dm644 $(SRCDIR)/msxtilemagic.py       $(DESTDIR)$(PREFIX)/bin/msxtilemagic.py
	install -Dm644 $(SRCDIR)/supertilerandomizer.py $(DESTDIR)$(PREFIX)/bin/supertilerandomizer.py
	install -Dm644 $(SRCDIR)/tilerandomizer.py     $(DESTDIR)$(PREFIX)/bin/tilerandomizer.py

	# Install wrapper script
	install -Dm755 wrapper.sh $(DESTDIR)$(PREFIX)/bin/msxtileforge

	# Install desktop integration
	install -Dm644 io.github.DamnedAngel.msx-tile-forge.png \
		$(DESTDIR)$(PREFIX)/share/icons/hicolor/256x256/apps/io.github.DamnedAngel.msx-tile-forge.png
	install -Dm644 io.github.DamnedAngel.msx-tile-forge.desktop \
		$(DESTDIR)$(PREFIX)/share/applications/io.github.DamnedAngel.msx-tile-forge.desktop
	install -Dm644 io.github.DamnedAngel.msx-tile-forge.metainfo.xml \
		$(DESTDIR)$(PREFIX)/share/metainfo/$(FLATPAK_ID).metainfo.xml

