/*
**
** (C) 2012 Adrian Ulrich
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
**
*/




#define GBUFFSIZE 64                                /* generic buffer size                       */
#define CALLVOLUME_CMDLEN 14                        /* minimum length of libcallvolume commands  */

#define SOCKET_PATH "/dev/socket/rild-audio-gsm"    /* socket to use                             */
#define AT_PREFIX "AT+XDRV="                        /* Prefix for the AT-Commands we are sending */

#define USER_MEDIA  1013                            /* owner of audio socket and our UID         */
#define JPOLLY_PATH \
      "/data/data/ch.blinkenlights.android.polly"   /* We will inherit our GID from the owner    */

#define SEC_SLEEP   3                               /* how long we wait before terminating       */
#define AT_TIMEOUT  3                               /* terminate if a command took longer this   */
#define MUX_PTS_FIRST 1                             /* lowest PTS to consider                    */
#define MUX_PTS_LAST  7                             /* last PTS to consider for gsmmux           */

#define TERM_MAGIC "AT+XDRV=DEAD_PARROT"            /* pollyd will commit suicide if this string *
                                                     * is received by the daemon                 */
#define TERM_LEN   strlen(TERM_MAGIC)
#define TERM_DELAY 10-SEC_SLEEP                     /* sleep X second after receiving TERM_MAGIC */

/* for debugging */
#define DEBUG 1
#define DMSG(fmt, ...) \
        do { if (DEBUG) { fprintf(stderr, "DEBUG(%-20s): ", __func__); fprintf(stderr, fmt, __VA_ARGS__); fprintf(stderr, "\n"); }} while (0)


void xdie(char *msg);
void send_xdrv_command(const char *cmd, int fd);
int racy_get_free_pts();
int get_pts_socket();
int get_audio_socket();
int at_args_sane(char *buffer, size_t bufflen);
gid_t get_jpolly_gid();
void suicide (int sig);
