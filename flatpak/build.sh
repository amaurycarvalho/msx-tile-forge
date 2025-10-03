#!/bin/sh
set -e

# Use Flatpak environment vars
APP_VERSION="${APP_VERSION:-0.0.0}"
FLATPAK_ID="${FLATPAK_ID:-io.github.DamnedAngel.msx-tile-forge}"
FLATPAK_DEST="${FLATPAK_DEST:-/app}"
APP_SRC="."
FLATPAK_SRC="flatpak"

echo "==> Building ${FLATPAK_ID} version ${APP_VERSION}"

# Patch version in Python scripts
find . -type f -name "*.py" -exec sed -i "s/<unreleased>/${APP_VERSION}/g" {} +

# Install Python entry points
install -Dm644 "${APP_SRC}/msxtileforge.py" "${FLATPAK_DEST}/bin/msxtileforge.py"
install -Dm644 "${APP_SRC}/msxtileexport.py" "${FLATPAK_DEST}/bin/msxtileexport.py"
install -Dm644 "${APP_SRC}/msxtilemagic.py" "${FLATPAK_DEST}/bin/msxtilemagic.py"
install -Dm644 "${APP_SRC}/supertilerandomizer.py" "${FLATPAK_DEST}/bin/supertilerandomizer.py"
install -Dm644 "${APP_SRC}/tilerandomizer.py" "${FLATPAK_DEST}/bin/tilerandomizer.py"

# Install wrapper as executable
install -Dm755 "${FLATPAK_SRC}/wrapper.sh" "${FLATPAK_DEST}/bin/msxtileforge"

# Desktop integration
install -Dm644 "${FLATPAK_SRC}/io.github.DamnedAngel.msx-tile-forge.png" \
  "${FLATPAK_DEST}/share/icons/hicolor/256x256/apps/io.github.DamnedAngel.msx-tile-forge.png"

install -Dm644 "${FLATPAK_SRC}/io.github.DamnedAngel.msx-tile-forge.desktop" \
  "${FLATPAK_DEST}/share/applications/io.github.DamnedAngel.msx-tile-forge.desktop"

install -Dm644 "${FLATPAK_SRC}/io.github.DamnedAngel.msx-tile-forge.metainfo.xml" \
  "${FLATPAK_DEST}/share/metainfo/${FLATPAK_ID}.metainfo.xml"

echo "==> Build completed."


