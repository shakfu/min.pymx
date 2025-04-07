MAX_VERSION := 9
PACKAGE_NAME := min.pymx
MAX_PACKAGE := "$(HOME)/Documents/Max\ $(MAX_VERSION)/Packages/$(PACKAGE_NAME)"
SCRIPTS := source/scripts
BUILD := build
CONFIG = Release
THIRDPARTY = $(BUILD)/thirdparty
LIB = $(THIRDPARTY)/install/lib
DIST = $(BUILD)/dist/$(PACKAGE_NAME)
ARCH=$(shell uname -m)
DMG=$(PACKAGE_NAME)-$(VERSION)-$(ARCH).dmg
ENTITLEMENTS = source/scripts/entitlements.plist
VERSION=0.1.0

PYEXE=$(shell python3 -c "import sys; print(sys.executable)")

.PHONY: all build setup clean reset

all: build


build: reset
	@mkdir -p build && \
		cd build && \
		cmake -GXcode .. \
			-DENABLE_HOMEBREW=ON \
			-DPYTHON_EXECUTABLE=$(PYEXE) \
			-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
			.. && \
		cmake --build . --config '$(CONFIG)' && \
		cmake --install . --config '$(CONFIG)'

clean:
	@rm -rf \
		build \
		externals

reset:
	@rm -rf build externals

setup:
	@git submodule init
	@git submodule update
	@if ! [ -L "$(MAX_PACKAGE)" ]; then \
		ln -s "$(shell pwd)" "$(MAX_PACKAGE)" ; \
		echo "... symlink created" ; \
	else \
		echo "... symlink already exists" ; \
	fi

