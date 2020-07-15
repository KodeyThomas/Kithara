THEOS_DEVICE_IP = 192.168.1.152
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = kithara

kithara_FILES = kithara.x apiCall/apiCall.m
kithara_CFLAGS = -fobjc-arc
kithara_PRIVATE_FRAMEWORKS = SystemStatusServer
kithara_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += kitharaprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
