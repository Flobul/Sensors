ARCHS = arm64 armv7 armv7s armv6
TARGET = iphone:clang:latest:9.0
include $(THEOS)/makefiles/common.mk

TOOL_NAME = sensors
sensors_FILES = main.m
sensors_CFLAGS = -fobjc-arc
sensors_FRAMEWORKS = IOKit Foundation

include $(THEOS_MAKE_PATH)/tool.mk
