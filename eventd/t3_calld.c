/*
 * Copyright (C) 2012 Illes Pal Zoltan, illespal@gmail.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/input.h>

/**
 *	program reads alsa card1's special state and it will use a blob bin to
 *	change overall sys volume based on /data/misc/in_call_vol file param. 
 *      If call finished (alsa card1 state back to normal) it will set it back to default (15).
 */

int isInCall()
{
	static const char call_state_filename[] = "/data/misc/call_state";
	system("echo `alsa_amixer -c 1 -i contents|grep :|head -n2|tail -n1` > /data/misc/call_state");
	int r;
	r = 0;
	FILE *file = fopen ( call_state_filename, "r" );
	if ( file != NULL )
	{
		char line [ 128 ]; 
		while ( fgets ( line, sizeof line, file ) != NULL ) /* read a line */
		{
			fputs ( line, stdout ); /* write the line to stdout */
			if ( strcmp(line,": values=1\n") == 0) // call / bt call
			{
				r = 1;
			}
			break;
		}
	}
	fclose ( file );
	return r;

}


int main()
{
	printf("endeavoru - in call volume adjustment - t3_calld starting.\n");
	printf("(c) 2012 Illes Pal Zoltan aka tbalden\n");
	int fbfd = 0;
	int keyfd = 0;
	int backlightfd = 0;
	struct input_event event;

	keyfd = open("/dev/input/event2", O_RDWR);
	if (!keyfd) {
		printf("Error: cannot open gpio-event input device.\n");
		exit(1);
	}

	int volumeNeedReset = 0;
	char buffer [50];

	static const char vol_filename[] = "/data/misc/in_call_vol";
	//static const char filename[] = "/proc/asound/card1/pcm0p/sub0/status";

	while(1) {

		FILE *vol_file = fopen ( vol_filename, "r" );
		if ( vol_file != NULL )
		{
			if (isInCall())
			{
				volumeNeedReset = 1;
				char line [ 128 ]; 
				if ( fgets ( line, sizeof line, vol_file ) != NULL )
				{
					sprintf(buffer, "/system/bin/snd3008 -v %s", line);
					printf("set volume to: %s\n",buffer);
					system(buffer);
				}
			} else
			{
				if (volumeNeedReset)
				{
					// no call, but vol_file present: delete it and set overall volume to max
					printf("call ended, overall volume back to max\n");
					volumeNeedReset = 0;
					sleep(1);
					system("/system/bin/snd3008 -v 15");
				}
			}
			fclose ( vol_file );
		} else
		{
			printf("no /data/misc/in_call_vol file. sleep."); 
		}
		sleep(2-volumeNeedReset); // if volume might need reset (in call or just ended), lets sleep only 1 sec
	}
	return 0;
}
