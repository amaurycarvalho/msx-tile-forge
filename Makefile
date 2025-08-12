# ----------------------------
# Usage
# ----------------------------
# Build everything
#   make all
# Build only Debian package (NOTE: change app version on debian/changelog)
#   make debian
# Build only Docker container
#   make docker
# Build only Flatpak
#   make flatpak
# Clean everything
#   make clean
# ----------------------------

# Variables
DOCKER_IMAGE_NAME = msx-tile-forge-vnc
DOCKER_TAG = latest
DEPLOY_DIR = deploy
FLATPAK_MANIFEST = org.msx.TileForge.yaml
APP_ID = org.msx.TileForge
DEB_PACKAGE = msx-tile-forge_*.deb

.PHONY: all clean docker flatpak debian prepare

all: prepare debian #docker flatpak
	@echo "✅ All builds completed. Files in $(DEPLOY_DIR)/"

prepare:
	@mkdir -p $(DEPLOY_DIR)

# ----------------------------
# Debian package build
# ----------------------------
debian:
	@echo "📦 Building Debian package..."
	debuild -us -uc -b -tc
#dh_clean
	@mv ../$(DEB_PACKAGE) $(DEPLOY_DIR)/
	@rm -f ../*.changes ../*.build ../*.buildinfo
	@echo "✅ Debian package saved to $(DEPLOY_DIR)/$(DEB_PACKAGE)"

# ----------------------------
# Docker VNC container build
# ----------------------------
docker:
	@echo "🐳 Building Docker VNC container..."
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) -f Dockerfile.vnc .
	docker save $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) | gzip > $(DEPLOY_DIR)/$(DOCKER_IMAGE_NAME)_$(DOCKER_TAG).tar.gz
	@echo "✅ Docker container saved to $(DEPLOY_DIR)/$(DOCKER_IMAGE_NAME)_$(DOCKER_TAG).tar.gz"

# ----------------------------
# Flatpak build
# ----------------------------
flatpak:
	@echo "📦 Building Flatpak bundle..."
	flatpak-builder --force-clean build-dir $(FLATPAK_MANIFEST) --install-deps-from=flathub
	flatpak build-bundle build-dir $(DEPLOY_DIR)/$(APP_ID).flatpak $(APP_ID) stable
	@echo "✅ Flatpak bundle saved to $(DEPLOY_DIR)/$(APP_ID).flatpak"

# ----------------------------
# Cleanup
# ----------------------------
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf $(DEPLOY_DIR)/*
	@echo "✅ Clean complete."
