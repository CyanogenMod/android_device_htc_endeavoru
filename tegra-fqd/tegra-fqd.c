#include <stdio.h>
#include <utils/Log.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <fcntl.h>
#include <sys/inotify.h>
#include "tegra-fqd.h"

#define LOG_TAG "tegra-fqd"
#define AID_SYSTEM  1000
#define AID_AUDIO   1005

static int *pp = power_profiles[0];


int main() {
	int fd;
	int wd;
	#define EV_BUFF 1024
	char buffer[EV_BUFF];
	
	fd = inotify_init();
	if(fd < 0)
		xdie("inotify_init failed!");
	
	/* create dir and try to watch it */
	umask(0);
	mkdir(WATCHDIR, S_IRWXU | S_IRWXG);
	chown(WATCHDIR, AID_SYSTEM, AID_AUDIO);
	wd = inotify_add_watch(fd, WATCHDIR, IN_CREATE|IN_DELETE);
	
	if(wd < 0)
		xdie("inotify_add_watch failed!");
	
	
	init_freq();
	
	for(;;) {
		ALOGI("inotify event\n");
		update_freq();
		read(fd, buffer, EV_BUFF);
	}
	close(fd);
	
	return 0;
}

static int bval(int a, int b) {
	return (a > b ? a : b );
}

/************************************************************
 * Called if inotify registered a change                    *
*************************************************************/
static void update_freq() {
	DIR *dfd;
	struct dirent *dentry;
	int i;
	int on;
	int minfreq;
	int maxfreq;
	
	dfd = opendir(WATCHDIR);
	if(dfd == NULL)
		xdie("opendir() failed");
	
	
	on = 0;
	minfreq = MINFREQ_BASE;
	
	while( (dentry = readdir(dfd)) != NULL ) {
		ALOGI("+ item %d %s %d\n", dentry->d_type, dentry->d_name, strcmp(T_SCREEN_ON, dentry->d_name));
		if(!strcmp(T_SCREEN_ON, dentry->d_name))
			on = 1;

		if(!strcmp(T_AUDIO_ON, dentry->d_name))
			minfreq = bval(minfreq, MINFREQ_AUDIO);
		if(!strcmp(T_A2DP_ON, dentry->d_name))
			minfreq = bval(minfreq, MINFREQ_A2DP);
		if(!strcmp(T_MTP_ON, dentry->d_name))
			minfreq = bval(minfreq, MINFREQ_MTP);
	}
	closedir(dfd);

	maxfreq = (on ? pp[0] : pp[1]);
	if(minfreq > maxfreq)
		maxfreq = minfreq;
	
	/* write twice to avoid state-change erros in the tegra cpufreq driver
	   (new_min > old_freq) */
	for(i=0;i<=1;i++) {
		sysfs_write("/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq",         minfreq);
		sysfs_write("/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq",         maxfreq);
		sysfs_write("/sys/module/cpu_tegra/parameters/cpu_user_cap",                 maxfreq); /* same as max_freq */
	}
	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/boost_factor",      on ? pp[2] : pp[3]);
	sysfs_write("/sys/kernel/tegra_cap/core_cap_level",                          on ? pp[4] : pp[5]);	
	sysfs_write("/sys/kernel/tegra_cap/core_cap_state",                          on ? pp[6] : pp[7]); /* always enabled (?) */
	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/max_boost",         on ? pp[8] : pp[9]);
	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load",  on ? pp[10]: pp[11]);

}


/************************************************************
 * Set initial govenor values and initialize *pp            *
*************************************************************/
static void init_freq() {
	char buf[4] = { 0 };
	int pprofile;
	
	int fd = open("/data/misc/adrian_pp", O_RDONLY);
	if( fd >= 0 ) {
		read(fd, buf, sizeof(buf)-1);
		close(fd);
		pprofile = atoi(buf);
		if(pprofile >= 0 && pprofile < MAX_POWER_PROFILES) {
			ALOGI("power profile set to %d", pprofile);
				pp = power_profiles[pprofile];
		}
	}

	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/min_sample_time", 30000);
	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load", 80);
	sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/boost_factor", 0);
}


/************************************************************
 * Logs a fatal error and exits                             *
*************************************************************/
static void xdie(char *e) {
	printf("FATAL ERROR: %s\n", e);
	ALOGE("FATAL ERROR: %s\n", e);
	exit(1);
}


/************************************************************
 * Write integer to sysfs file                              *
*************************************************************/
static void sysfs_write(char *path, int value) {
	char buf[80];
	int len;
	int fd = open(path, O_WRONLY);

	if (fd < 0) {
		strerror_r(errno, buf, sizeof(buf));
		ALOGE("Error opening %s: %s\n", path, buf);
		return;
	}

	snprintf(buf, sizeof(buf)-1, "%d", value);
	len = write(fd, buf, strlen(buf));
	if (len < 0) {
		strerror_r(errno, buf, sizeof(buf));
		ALOGE("Error writing to %s: %s\n", path, buf);
	}
	else {
		ALOGI("Wrote %s to %s\n", buf, path);
	}
	close(fd);
}

