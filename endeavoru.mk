#
# Copyright (C) 2010 The Android Open Source Project
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
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/endeavoru/overlay

# Set default USB interface
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage,adb

# Don't store dalvik on /cache, it gets annoying when /cache is wiped
# by us to enable booting into recovery after flashing boot.img
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/fstab.endeavoru:root/fstab.endeavoru \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.rc:root/init.endeavoru.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.usb.rc:root/init.endeavoru.usb.rc \
    $(LOCAL_PATH)/ramdisk/init.rc:root/init.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.endeavoru.rc:root/ueventd.endeavoru.rc

PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml)

# media config xml file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# media codec config xml file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml

# bluetooth config
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.conf:system/etc/bluetooth/main.conf

# configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/config/nvram_4329.txt:system/etc/nvram_4329.txt \
    $(LOCAL_PATH)/config/nvram_4330.txt:system/etc/nvram_4330.txt

# audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/audio/audio_effects.conf:system/etc/audio_effects.conf

# misc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/model_frontal.xml:system/etc/model_frontal.xml

# nfc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfcee_access.xml:system/etc/nfcee_access.xml

# Other extra packages
PRODUCT_PACKAGES += \
    librs_jni

# Bluetooth tools
PRODUCT_PACKAGES += \
    l2ping \
    hciconfig \
    hcitool \
    libbt-vendor

# audio packages
PRODUCT_PACKAGES += \
    tinymix \
    tinyplay \
    tinycap

# Wi-Fi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd.conf \
    wifical.sh \
    TQS_D_1.7.ini \
    crda \
    regulatory.bin \
    wlconf

$(call inherit-product-if-exists, vendor/htc/endeavoru/endeavoru-vendor.mk)

# common tegra3-HOX+ configs
$(call inherit-product, device/htc/tegra3-common/tegra3.mk)
