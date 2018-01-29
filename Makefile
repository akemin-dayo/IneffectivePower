TARGET =: clang
ARCHS = armv7 armv7s arm64
DEBUG = 0
GO_EASY_ON_ME = 1

THEOS_PACKAGE_DIR_NAME = debs
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IneffectivePower
IneffectivePower_FILES = IneffectivePower.xm
IneffectivePower_FRAMEWORKS = CoreText CoreFoundation

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	chmod -R 755 $(THEOS_STAGING_DIR)

after-install::
	install.exec "killall -9 backboardd"
