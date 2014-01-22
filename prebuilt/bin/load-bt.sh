#!/system/bin/sh
# Script to support kernels with old and updated ti-st driver together with the
# TI libbt-vendor library.

# Device created by the stock HTC kernel and expected by some HTC libs
DEV_HTC="/dev/tihci"
# Device created by the newer OMAP ti-st driver and also needed by the stock
# libbt-vendor library that we use.
DEV_STOCK="/dev/hci_tty"

if [ -e "$DEV_HTC" -a -e "$DEV_STOCK" ]; then
    echo "$DEV_HTC and $DEV_STOCK already exist"
    return 0
fi

# Wait a bit to make sure uim-sysfs inserted the st_drv module
/system/bin/sleep 2

# Load the module that exists
if [ -e "/system/lib/modules/hci_if_drv.ko" ]; then
    # New module name
    /system/bin/insmod /system/lib/modules/hci_if_drv.ko
elif [ -e "/system/lib/modules/ti_hci_drv.ko" ]; then
    # Old module name
    /system/bin/insmod /system/lib/modules/ti_hci_drv.ko
else
    echo "Error: No module found"
    return 1
fi


# Symlink existing device node to not existing device node
for TRIES in 1 2 3 4 5; do
    if [ -e "$DEV_HTC" -a ! -e "$DEV_STOCK" ]; then
        echo "$DEV_STOCK -> $DEV_HTC"
        /system/bin/ln -s "$DEV_HTC" "$DEV_STOCK"
        return 0
    elif [ -e "$DEV_STOCK" -a ! -e "$DEV_HTC"  ]; then
        echo "$DEV_HTC -> $DEV_STOCK"
        /system/bin/ln -s "$DEV_STOCK" "$DEV_HTC"
        return 0
    else
        echo "Waiting for device node to become available"
        /system/bin/sleep 2
    fi
done

echo "Error: Neither $DEV_HTC nor $DEV_STOCK appeared"
return 1
