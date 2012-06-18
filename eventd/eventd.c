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
 *	program reads gpio events, upon vol up/down and alsa card1's special state it will use a blob bin to
 *	change overall sys volume. otherwise it will set it back to default (15).
 */

int main()
{
	printf("endeavoru - in call volume adjustment - eventd starting.\n");
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

	int cVol = 15;
	char buffer [50];

	static const char filename[] = "/proc/asound/card1/pcm0p/sub0/status";

	while(1) {
		int ret = read(keyfd, &event, sizeof(struct input_event));
		if (ret == sizeof(struct input_event))
		{
			printf("type:%d code:%d value:%d\n", event.type, event.code, event.value);
			if (event.type!= 5 && event.type!=1)
			{
			    continue;
			}			
			if (event.type == 1 && event.code == 115 && event.value == 0)
			{
			    printf("VOL UP\n");


				FILE *file = fopen ( filename, "r" );
				if ( file != NULL )
				{
					char line [ 128 ]; 
					while ( fgets ( line, sizeof line, file ) != NULL ) /* read a line */
					{
						fputs ( line, stdout ); /* write the line to stdout */
						if ( strcmp(line,"state: XRUN\n") == 0 || strcmp(line,"state: PREPARED\n") == 0) // call / bt call
						{

							if (cVol>=15) cVol = 15; else cVol+=2;
							sprintf(buffer, "/system/bin/snd3008 -v %d", cVol);
							system(buffer);
						} else
						{
							if (cVol!=15)
							{
								cVol = 15;
								system("/system/bin/snd3008 -v 15");
							}
						}
						break;
					}
					fclose ( file );
				}

			
			    
			    
			}
			if (event.type == 1 && event.code == 114 && event.value == 0)
			{
			    printf("VOL DOWN\n");
				FILE *file = fopen ( filename, "r" );
				if ( file != NULL )
				{
					char line [ 128 ]; 
					while ( fgets ( line, sizeof line, file ) != NULL ) /* read a line */
					{
						fputs ( line, stdout ); /* write the line */
						if ( strcmp(line,"state: XRUN\n") == 0 || strcmp(line,"state: PREPARED\n") == 0) // call / bt call
						{
							if (cVol<=7) cVol = 7; else cVol-=2;
							sprintf(buffer, "/system/bin/snd3008 -v %d", cVol);
							system(buffer);
						} else
						{
							if (cVol!=15)
							{
								cVol = 15;
								system("/system/bin/snd3008 -v 15");
							}
						}
						break;
					}
					fclose ( file );
				}
			    
			}
		}
		else {
			if (ret>0)
			{
			    printf("read len:%d\n", ret);
			}
			continue;
		}
	}
	return 0;
}
