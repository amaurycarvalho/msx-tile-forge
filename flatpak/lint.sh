# Clean old builds
rm -rf build-dir

# Show flatpak runtime installed python version
flatpak run --command=python3 org.freedesktop.Platform//24.08 --version

# Lint manifest
flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest io.github.DamnedAngel.msx-tile-forge.yaml

# Build completely (install app files)
flatpak-builder --force-clean build-dir io.github.DamnedAngel.msx-tile-forge.yaml

# Lint appdir content
flatpak run --command=flatpak-builder-lint org.flatpak.Builder builddir build-dir

# Test run
flatpak-builder --run build-dir io.github.DamnedAngel.msx-tile-forge.yaml msxtileforge

