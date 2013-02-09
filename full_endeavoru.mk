#
# Copyright (C) 2012 The Android Open-Source Project
# Copyright (C) 2012 The CyanogenMod Project
# Copyright (C) 2012 mdeejay <mdjrussia@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

DEVICE_PACKAGE_OVERLAYS := device/htc/endeavoru/overlay

# Files needed for boot image
PRODUCT_COPY_FILES := \
	device/htc/endeavoru/ramdisk/init.rc:root/init.rc \
	device/htc/endeavoru/ramdisk/init.endeavoru.rc:root/init.endeavoru.rc \
	device/htc/endeavoru/ramdisk/init.usb.rc:root/init.usb.rc \
	device/htc/endeavoru/ramdisk/ueventd.rc:root/ueventd.rc \
	device/htc/endeavoru/ramdisk/ueventd.endeavoru.rc:root/ueventd.endeavoru.rc \
        device/htc/endeavoru/ramdisk/fstab.endeavoru.ext4:root/fstab.endeavoru.ext4 \
        device/htc/endeavoru/ramdisk/fstab.endeavoru.vfat:root/fstab.endeavoru.vfat \
        device/htc/endeavoru/ramdisk/fstab.endeavoru:root/fstab.endeavoru \
	device/htc/endeavoru/ramdisk/endeavoru_mounthelper.sh:root/endeavoru_mounthelper.sh \
	device/htc/endeavoru/ramdisk/wifi_loader.sh:root/wifi_loader.sh \
	device/htc/endeavoru/ramdisk/init:root/init

# Prebuilt Audio/GPS/Camera configs
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/dsp/asound.conf:system/etc/asound.conf \
	device/htc/endeavoru/dsp/AIC3008_REG_DualMic_XC.csv:system/etc/AIC3008_REG_DualMic_XC.csv \
	device/htc/endeavoru/dsp/AIC3008_REG_DualMic.csv:system/etc/AIC3008_REG_DualMic.csv \
	device/htc/endeavoru/dsp/DSP_number.txt:system/etc/DSP_number.txt \
	device/htc/endeavoru/configs/nvcamera.conf:system/etc/nvcamera.conf \
	device/htc/endeavoru/configs/media_profiles.xml:system/etc/media_profiles.xml \
	device/htc/endeavoru/configs/enctune.conf:system/etc/enctune.conf \
	device/htc/endeavoru/configs/gps.conf:system/etc/gps.conf

# BT config
PRODUCT_COPY_FILES += \
	system/bluetooth/data/main.conf:system/etc/bluetooth/main.conf

# netd prebuilt from AOSP hox hacked, no reload. tether works with this, temporarily fix. Thanks for Adrian Ulrich
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/prebuilt/netd:system/bin/netd

# Prebuilt Alsa configs
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/usr/share/alsa/alsa.conf:system/usr/share/alsa/alsa.conf \
	device/htc/endeavoru/usr/share/alsa/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
	device/htc/endeavoru/usr/share/alsa/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf

# Vold.fstab
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/vold.fstab:system/etc/vold.fstab

# Media configs
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/media_codecs.xml:system/etc/media_codecs.xml

# Input device configeration files
PRODUCT_COPY_FILES += \
	device/htc/endeavoru/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
	device/htc/endeavoru/usr/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
	device/htc/endeavoru/usr/idc/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
	device/htc/endeavoru/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
	device/htc/endeavoru/usr/idc/tv-touchscreen.idc:system/usr/idc/tv-touchscreen.idc

# Camera
PRODUCT_PACKAGES := \
	camera.tegra \
	libsurfaceflinger_client

# Torch
PRODUCT_PACKAGES += \
	Torch

# Polly
PRODUCT_PACKAGES += \
	pollyd \
	Polly

# hox tools
PRODUCT_PACKAGES += \
	ugexec \
	libbt-vendor \
	hox-uim-sysfs 
#\
#        tegra-fqd

# Stagefright
PRODUCT_PACKAGES += \
	libstagefrighthw


# WI-Fi
PRODUCT_PACKAGES += \
	dhcpcd.conf \
	hostapd.conf \
	wifical.sh \
	TQS_D_1.7.ini \
	TQS_D_1.7_127x.ini \
	crda \
	regulatory.bin \
	hostapd \
	hostapd_cli \
	calibrator \
	iw

# BlueZ test tools & Shared Transport user space mgr
PRODUCT_PACKAGES += \
	hciconfig \
	hcitool

# lights
PRODUCT_PACKAGES += \
	lights.endeavoru

# Power HAL
PRODUCT_PACKAGES += \
	power.endeavoru

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	libaudioutils \
	libtinyalsa \
	tinymix \
	tinyplay \
	tinycap

# NFC
PRODUCT_PACKAGES += \
	libnfc \
	libnfc_ndef \
	libnfc_jni \
	Nfc \
	Tag \
	com.android.nfc_extras

# Live Wallpapers
PRODUCT_PACKAGES += \
	librs_jni

# Common
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs \
	l2ping \
	com.android.future.usb.accessory

# for bugmailer
ifneq ($(TARGET_BUILD_VARIANT),user)
	PRODUCT_PACKAGES += send_bug
	PRODUCT_COPY_FILES += \
		system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
		system/extras/bugmailer/send_bug:system/bin/send_bug
endif

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Other overrides
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.locationfeatures=1 \
	ro.setupwizard.enable_bypass=1 \
	dalvik.vm.execution-mode=int:jit \
	dalvik.vm.lockprof.threshold=500 \
	dalvik.vm.dexopt-flags=m=y \
	wifi.softap.interface=wlan0 \
	wifi.softapconcurrent.interface=wlan0 \
	persist.sys.usb.config=mtp,adb

# Tegra 3 specific overrides
PRODUCT_PROPERTY_OVERRIDES += \
	persist.tegra.nvmmlite=1 \
	tf.enable=y

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_LOCALES += en_US xhdpi

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product-if-exists, vendor/htc/endeavoru/endeavoru-vendor.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
