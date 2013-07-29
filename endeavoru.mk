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

PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

DEVICE_PACKAGE_OVERLAYS += device/htc/endeavoru/overlay

# Set default USB interface
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage,adb

# Don't store dalvik on /cache, it gets annoying when /cache is wiped
# by us to enable booting into recovery after flashing boot.img
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# EndeavorU is similar to Galaxy Nexus in terms of RAM
include frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/fstab.endeavoru:root/fstab.endeavoru \
    $(LOCAL_PATH)/ramdisk/init:root/init \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.rc:root/init.endeavoru.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.usb.rc:root/init.endeavoru.usb.rc \
    $(LOCAL_PATH)/ramdisk/init.rc:root/init.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.endeavoru.rc:root/ueventd.endeavoru.rc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml)

# Input config files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/usr/idc/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
    $(LOCAL_PATH)/prebuilt/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    $(LOCAL_PATH)/prebuilt/usr/idc/tv-touchscreen.idc:system/usr/idc/tv-touchscreen.idc \
    $(LOCAL_PATH)/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    $(LOCAL_PATH)/prebuilt/usr/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl

# audio misc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
    $(LOCAL_PATH)/prebuilt/usr/share/alsa/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf

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
    $(LOCAL_PATH)/config/enctune.conf:system/etc/enctune.conf \
    $(LOCAL_PATH)/config/Flash_Loader.conf:system/etc/Flash_Loader.conf \
    $(LOCAL_PATH)/config/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/config/nvcamera.conf:system/etc/nvcamera.conf \
    $(LOCAL_PATH)/config/nvram_4329.txt:system/etc/nvram_4329.txt \
    $(LOCAL_PATH)/config/nvram_4330.txt:system/etc/nvram_4330.txt

# audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/audio/AIC3008_REG_DualMic.csv:system/etc/AIC3008_REG_DualMic.csv \
    $(LOCAL_PATH)/prebuilt/audio/AIC3008_REG_DualMic_XC.csv:system/etc/AIC3008_REG_DualMic_XC.csv \
    $(LOCAL_PATH)/prebuilt/audio/asound.conf:system/etc/asound.conf \
    $(LOCAL_PATH)/prebuilt/audio/audio_effects.conf:system/etc/audio_effects.conf \
    $(LOCAL_PATH)/prebuilt/audio/DSP_number.txt:system/etc/DSP_number.txt \
    $(LOCAL_PATH)/prebuilt/audio/alsa.conf:system/usr/share/alsa/alsa.conf

# misc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/model_frontal.xml:system/etc/model_frontal.xml

# nfc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfcee_access.xml:system/etc/nfcee_access.xml

# Torch
PRODUCT_PACKAGES += \
    Torch

# Other extra packages
PRODUCT_PACKAGES += \
    librs_jni \
    make_ext4fs \
    setup_fs \
    com.android.future.usb.accessory

# lights
PRODUCT_PACKAGES += \
    lights.tegra

# Camera wrapper
PRODUCT_PACKAGES += \
    camera.tegra

# Bluetooth tools
PRODUCT_PACKAGES += \
    l2ping \
    hciconfig \
    hcitool \
    libbt-vendor

# NFC packages
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

# audio packages
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaudioutils \
    libtinyalsa \
    tinymix \
    tinyplay \
    tinycap

# pollyd (respect & thanks to Adrian Ulrich <adrian@blinkenlights.ch> )
PRODUCT_PACKAGES += \
    pollyd \
    Polly

PRODUCT_PACKAGES += \
    EndeavoruParts


# Wi-Fi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd.conf \
    wifical.sh \
    TQS_D_1.7.ini \
    crda \
    regulatory.bin \
    calibrator \
    wlconf

$(call inherit-product-if-exists, vendor/htc/endeavoru/endeavoru-vendor.mk)
