#!/system/bin/sh -e
# Simulate HTCs wl12xx calibration.

TAG="WifiCalibration"

OUTPUT_DIR="/data/misc/wifi"
NVS_FILE="$OUTPUT_DIR/wl1271-nvs-calibrated.bin"
AUTO_NVS_FILE="$OUTPUT_DIR/wl1271-nvs-calibrated_auto.bin"
INI_FILE="/system/etc/wifi/TQS_D_1.7.ini"
MODULE="/system/lib/modules/wl12xx_sdio.ko"
MAC="00:01:02:03:04:05"

if [ ! -e "$NVS_FILE" ]; then
    log -t "$TAG" -p i "$NVS_FILE does not exist, creating..."
    logwrapper /system/bin/calibrator set upd_nvs "$INI_FILE" /proc/calibration "$NVS_FILE"
    /system/bin/chmod 660 "$NVS_FILE"
    /system/bin/chown system.wifi "$NVS_FILE"

    log -t "$TAG" -p i "$NVS_FILE sucessfully created"
else
    log -t "$TAG" -p d "$NVS_FILE exists"
fi

if [ ! -e "$AUTO_NVS_FILE" ]; then
    log -t "$TAG" -p i "$AUTO_NVS_FILE does not exist, creating..."

    logwrapper /system/bin/calibrator plt autocalibrate wlan0 "$MODULE" "$INI_FILE" "$AUTO_NVS_FILE" "$MAC"
    /system/bin/chmod 660 "$AUTO_NVS_FILE"
    /system/bin/chown system.wifi "$AUTO_NVS_FILE"

    log -t "$TAG" -p i "$AUTO_NVS_FILE sucessfully created"
else
    log -t "$TAG" -p d "$AUTO_NVS_FILE exists"
fi
