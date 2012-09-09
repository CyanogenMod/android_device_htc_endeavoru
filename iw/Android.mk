LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	bitrate.c \
	connect.c \
	cqm.c \
	event.c \
	genl.c \
	ibss.c \
	info.c \
	interface.c \
	iw.c \
	link.c \
	mesh.c \
	mpath.c \
	offch.c \
	phy.c \
	ps.c \
	reason.c \
	reg.c \
	scan.c \
	sections.c \
	station.c \
	status.c \
	survey.c \
	util.c \
	roc.c \
	wowlan.c \
	version.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	external/libnl-headers


LOCAL_NO_DEFAULT_COMPILER_FLAGS := true
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../libnl-headers \
	$(TARGET_PROJECT_INCLUDES) $(TARGET_C_INCLUDES)
LOCAL_CFLAGS := $(TARGET_GLOBAL_CFLAGS) $(PRIVATE_ARM_CFLAGS)

LOCAL_CFLAGS += -DCONFIG_LIBNL20=y

#LOCAL_SHARED_LIBRARIES += libnl_2
LOCAL_STATIC_LIBRARIES += libnl_2
LOCAL_MODULE := iw
LOCAL_LDFLAGS := -Wl,--no-gc-sections
LOCAL_MODULE_TAGS := debug
#LOCAL_SHARED_LIBRARIES := libnl
LOCAL_STATIC_LIBRARIES := libnl_2
LOCAL_MODULE := iw

include $(BUILD_EXECUTABLE)
