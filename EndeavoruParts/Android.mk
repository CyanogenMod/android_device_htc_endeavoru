LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := EndeavoruParts
LOCAL_CERTIFICATE := platform

# Required so that symbols used by the jni library doesn't get stripped out
LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
