INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WithFriends
WithFriends_FILES = Tweak.x BJBrainyQuotes.m
WithFriends_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
