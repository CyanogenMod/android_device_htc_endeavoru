#!/system/bin/sh
# Script to support kernels with old and updated ti-st driver together with the
# TI libbt-vendor library.

# Device created by the stock HTC kernel and our modified ti-st driver
DEV_HTC="/dev/tihci"
# Device created by the newer OMAP ti-st driver and also needed by the stock
# libbt-vendor library.
DEV_STOCK="/dev/hci_tty"

if [ -e "$DEV_HTC" -a -e "$DEV_STOCK" ]; then
    echo "$DEV_HTC and $DEV_STOCK already exist"
    return 0
fi

# Load the module that exists
if [ -e "/system/lib/modules/hci_if_drv.ko" ]; then
    # New module name
    /system/bin/insmod /system/lib/modules/hci_if_drv.ko
elif [ -e "/system/lib/modules/ti_hci_drv.ko" ]; then
    # Old module name
    /system/bin/insmod /system/lib/modules/ti_hci_drv.ko
fi

# Now try to find the major device number of whatever device what created and
# create the missing one with the same number. This provides compatibility with
# the TI libbt-vendor library and older libraries that still use the old name.

# Minor number is expected to be always 0
MINOR=0

# The device node we will create based on the existing one
DEV_TO_CREATE=""

if [ -e "$DEV_HTC" -a ! -e "$DEV_STOCK" ]; then
    MAJOR=`/system/bin/grep tihci /proc/devices | /system/xbin/cut -d " " -f1`
    DEV_TO_CREATE="$DEV_STOCK"
elif [ -e "$DEV_STOCK" -a ! -e "$DEV_HTC"  ]; then
    MAJOR=`/system/bin/grep hci_tty /proc/devices | /system/xbin/cut -d " " -f1`
    DEV_TO_CREATE="$DEV_HTC"
else
    echo "Error: Neither $DEV_HTC nor $DEV_STOCK exists"
    return 1
fi

echo "Creating $DEV_TO_CREATE with major $MAJOR, minor $MINOR"
/system/bin/mknod "$DEV_TO_CREATE" c $MAJOR $MINOR
/system/bin/chown bluetooth:bluetooth "$DEV_TO_CREATE"
/system/bin/chmod 0600 "$DEV_TO_CREATE"

