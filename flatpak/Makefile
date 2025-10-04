# Makefile for Flathub install of msx-tile-forge
# To use only by io.github.DamnedAngel.msx-tile-forge.yaml

# Defaults (can be overridden by environment/flatpak-builder)
APP_VERSION ?= 0.0.0
FLATPAK_ID ?= io.github.DamnedAngel.msx-tile-forge
FLATPAK_DEST ?= /app
APP_SRC := ..
FLATPAK_SRC := .

PY_SCRIPTS := \
	$(APP_SRC)/msxtileforge.py \
	$(APP_SRC)/msxtileexport.py \
	$(APP_SRC)/msxtilemagic.py \
	$(APP_SRC)/supertilerandomizer.py \
	$(APP_SRC)/tilerandomizer.py

ICON := $(FLATPAK_SRC)/io.github.DamnedAngel.msx-tile-forge.png
DESKTOP := $(FLATPAK_SRC)/io.github.DamnedAngel.msx-tile-forge.desktop
METAINFO := $(FLATPAK_SRC)/io.github.DamnedAngel.msx-tile-forge.metainfo.xml
WRAPPER := $(FLATPAK_SRC)/wrapper.sh

# Default target
all: nop

nop:

install:
	@echo "==> Building $(FLATPAK_ID) version $(APP_VERSION)"
	# Patch version in Python scripts
	find $(APP_SRC) -type f -name "*.py" -exec sed -i "s/<unreleased>/$(APP_VERSION)/g" {} +
	# Install Python entry points
	for f in $(PY_SCRIPTS); do \
		install -Dm644 $$f $(FLATPAK_DEST)/bin/$$(basename $$f); \
	done
	# Install wrapper
	install -Dm755 $(WRAPPER) $(FLATPAK_DEST)/bin/msxtileforge
	# Install icon
	install -Dm644 $(ICON) \
		$(FLATPAK_DEST)/share/icons/hicolor/256x256/apps/$(notdir $(ICON))
	# Install desktop entry
	install -Dm644 $(DESKTOP) \
		$(FLATPAK_DEST)/share/applications/$(notdir $(DESKTOP))
	# Install metainfo
	install -Dm644 $(METAINFO) \
		$(FLATPAK_DEST)/share/metainfo/$(FLATPAK_ID).metainfo.xml
	@echo "==> Build completed."

.PHONY: all nop install

