LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= tegra-fqd.c
LOCAL_MODULE := tegra-fqd
LOCAL_SHARED_LIBRARIES:= libcutils
include $(BUILD_EXECUTABLE)
