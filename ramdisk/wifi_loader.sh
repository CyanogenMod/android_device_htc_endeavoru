#!/system/bin/sh

function load()
{

    insmod /system/lib/modules/compat.ko
    insmod /system/lib/modules/cfg80211.ko
    insmod /system/lib/modules/mac80211.ko
    insmod /system/lib/modules/wl12xx.ko debug_level=0x63c00

}


function sleepload()
{
    sleep 10

    load

    sleep 10

    load

    sleep 10

    load

    sleep 10

    load

}

sleepload
sleepload
sleepload
