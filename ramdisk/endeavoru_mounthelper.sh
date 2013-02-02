#!/system/bin/sh

PART_SDCARD="/dev/block/platform/sdhci-tegra.3/by-name/ISD"
DEST_SDCARD="/data/media"

# use /data (UDA) as dalvik cache in bigdata mode
PART_DALVIK="/dev/block/platform/sdhci-tegra.3/by-name/UDA"
DEST_DALVIK="/data/dalvik-cache"

## mounts $PART_SDCARD to $DEST_SDCARD
## assumes a vfat formatted sdcard
function mount_vfat_sdcard() {
	# create mountpoint
	mkdir                    ${DEST_SDCARD}
	chown media_rw:media_rw  ${DEST_SDCARD}
	chmod 0770               ${DEST_SDCARD}
	echo 2 > /data/.layout_version
	#...and mount the volume with the correct permissions
	grep -q ${PART_SDCARD} /proc/mounts || fsck_msdos -p ${PART_SDCARD}
	mount -t vfat -o uid=1023,gid=1023,umask=0007 ${PART_SDCARD} ${DEST_SDCARD}
}

## mount dalvik cache
function mount_ext4_dalvik() {
	mkdir               ${DEST_DALVIK}
	
	e2fsck -y ${PART_DALVIK}
	mount -t ext4 -o noatime,nosuid,nodev,noauto_da_alloc,discard ${PART_DALVIK} ${DEST_DALVIK}
	#ensure sane permissions for dalvik cache directory
	chown system:system ${DEST_DALVIK}
	chmod 0771          ${DEST_DALVIK}
}

## migrates an 'old' storage layout to the 4.2 version
## only needed for vfat sdcards
function migrate_vfat_sdcard() {
	if [ -d ${DEST_SDCARD}/0 ]; then
		echo "Already using the 4.2 layout, no need to migrate"
		return
	fi
	
	if ! grep -q ${DEST_SDCARD} /proc/mounts; then
		echo "Sdcard not mounted, skipping migration"
		return
	fi
	
	echo "Migrating existing sdcard to 4.2 layout"
	# migrate existing sdcard data to 0/
	mkdir ${DEST_SDCARD}/0 || return  # should not happen!
	for x in ${DEST_SDCARD}/{*,.*} ; do
		mv $x ${DEST_SDCARD}/0
	done
}


## main ##

# exit if we are in 'enter decryption key' phase
grep -q "tmpfs /data" /proc/mounts  && exit

# TODO fix ext4 part!
#if readlink /fstab.endeavoru | grep -q vfat$ ; then
mount_vfat_sdcard
migrate_vfat_sdcard
#else
	# sdcard is ext4, so we are going to use this as data!
#	mount_ext4_dalvik
#fi


## tell init to continue
touch /dev/.endeavoru_mounthelper_done


