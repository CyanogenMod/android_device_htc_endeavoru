#!/system/bin/sh
#
# Cyanogenmod init.tegra.post_boot.sh
#

#don't use this for now, as it overwrites kernel defaults
#set interactive as default
#echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor interactive
#echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor interactive
#echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor interactive

#if interactive is the active governor set the default settings
if [ -d /sys/devices/system/cpu/cpufreq/interactive ] ; then
        echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
        echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
        echo 80 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
        if [ -f sys/devices/system/cpu/cpufreq/interactive/boost_factor ] ; then
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/boost_factor
        fi
        if [ -f /sys/devices/system/cpu/cpufreq/interactive/boost ] ; then
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/boost
        fi
        echo 1 > /sys/devices/system/cpu/cpufreq/interactive/input_boost
fi

