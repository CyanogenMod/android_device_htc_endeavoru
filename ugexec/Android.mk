LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= ugexec.c
LOCAL_MODULE := ugexec
include $(BUILD_EXECUTABLE)
