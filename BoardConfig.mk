#
# Copyright (C) 2012 The CyanogenMod Project
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

BOARD_USES_GENERIC_AUDIO := false
USE_CAMERA_STUB := false
TARGET_PROVIDES_LIBLIGHTS := true

#Camera
BOARD_HAVE_HTC_FFC := true

# Target arch settings
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a9
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Board nameing
TARGET_NO_RADIOIMAGE := true
TARGET_BOOTLOADER_BOARD_NAME := 
TARGET_BOARD_PLATFORM := tegra

# EGL settings
BOARD_EGL_CFG := device/htc/endeavoru/configs/egl.cfg
USE_OPENGL_RENDERER := true

# Wi-Fi
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WLAN_DEVICE := wl12xx_mac80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_SOFTAP_DEVICE_TI := NL80211
WIFI_DRIVER_MODULE_NAME	:=  "wl12xx_sdio"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wl12xx_sdio.ko"

# BT
BOARD_HAVE_BLUETOOTH := true

# Vold / USB
BOARD_VOLD_MAX_PARTITIONS := 20
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/fsl-tegra-udc/gadget/lun0/file

# Kernel / Ramdisk
TARGET_PREBUILT_KERNEL := device/htc/endeavoru/prebuilt/kernel
TARGET_PROVIDES_INIT_TARGET_RC := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1342177280
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2302672896
BOARD_FLASH_BLOCK_SIZE := 4096
