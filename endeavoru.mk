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

# Increase UMS speed
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=50

# Smoother window manager experience.
PRODUCT_PROPERTY_OVERRIDES += \
    windowsmgr.max_events_per_sec = 240 #300

# Old RIL features
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril.config=signalstrength,skipbrokendatacall

# force gpu rendering(2d drawing) [Nvidia setting - libhtc-opt2.so]
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.ui.hw=true

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/fstab.endeavoru:root/fstab.endeavoru \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.rc:root/init.endeavoru.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.htc.rc:root/init.endeavoru.htc.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.common.rc:root/init.endeavoru.common.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.usb.rc:root/init.endeavoru.usb.rc \
    $(LOCAL_PATH)/ramdisk/init.endeavoru.cm.rc:root/init.endeavoru.cm.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.endeavoru.rc:root/ueventd.endeavoru.rc

# configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf

# nfc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfcee_access.xml:system/etc/nfcee_access.xml

# Other extra packages
PRODUCT_PACKAGES += \
    librs_jni

# Bluetooth tools
$(call inherit-product, hardware/ti/wpan/ti-wpan-products.mk)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/bin/load-bt.sh:system/bin/load-bt.sh
PRODUCT_PACKAGES += \
    l2ping \
    hciconfig \
    hcitool \

# audio packages
PRODUCT_PACKAGES += \
    tinymix \
    tinyplay \
    tinycap

# Wi-Fi
$(call inherit-product, hardware/ti/wlan/mac80211/wl128x-wlan-products.mk)
PRODUCT_COPY_FILES +=
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/prebuilt/bin/wifi_calibration.sh:system/bin/wifi_calibration.sh \
     $(LOCAL_PATH)/configs/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
     $(LOCAL_PATH)/configs/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf
PRODUCT_PACKAGES += \
    wifical.sh \
    128x_TQS_D_1.7.ini \
    calibrator \
    crda \
    regulatory.bin \
    wlconf
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
$(call inherit-product, vendor/htc/endeavoru/endeavoru-vendor.mk)

# common tegra3-HOX+ configs
$(call inherit-product, device/htc/tegra3-common/tegra3.mk)
