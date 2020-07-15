ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = KitharaPrefs

KitharaPrefs_FILES = KITHRootListController.m
KitharaPrefs_FRAMEWORKS = UIKit
KitharaPrefs_PRIVATE_FRAMEWORKS = Preferences
KitharaPrefs_EXTRA_FRAMEWORKS = CepheiPrefs Cephei
KitharaPrefs_INSTALL_PATH = /Library/PreferenceBundles
KitharaPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
