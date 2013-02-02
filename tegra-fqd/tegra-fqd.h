/* functions */
static void xdie(char *e);
static void update_freq();
static void init_freq();
static void sysfs_write(char *path, int value);
static int bval(int a, int b);

/* Tegra Power Profiles */
#define MAX_POWER_PROFILES 5
static int power_profiles[MAX_POWER_PROFILES][12] = {
 /*   scaling_max_freq    boost_factor ccap_level,   ccap_st,  max_boost,    go_maxspeed                 */
    { 1500000, 475000,    0, 2,        1300, 1200,    1, 1,    0, 250000,    85, 95 }, /* NVidia default */
    {  880000, 204000,    0, 2,        1300, 1200,    1, 1,    0, 250000,    85, 95 }, /* Sane           */
    {  640000, 204000,    0, 2,        1300, 1200,    1, 1,    0, 250000,    85, 95 }, /* ok             */
    {  475000, 204000,    0, 2,        1300, 1200,    1, 1,    0, 250000,    85, 95 }, /* insane         */
    {  340000, 204000,    0, 2,        1300, 1200,    1, 1,    0, 250000,    85, 95 }, /* stupid         */
};

/* directory to watch via inotify */
#define WATCHDIR "/dev/.tegra-fqd"

#define T_SCREEN_ON "screen_on"
#define T_AUDIO_ON  "audio_on"
#define T_A2DP_ON   "a2dp_on"
#define T_MTP_ON    "mtp_on"

#define MINFREQ_BASE   51000   /* lowest supported frequency            */
#define MINFREQ_AUDIO 102000   /* min. frequency while playing audio    */
#define MINFREQ_A2DP  204000   /* min. freq to use while on BT audio    */
#define MINFREQ_MTP   475000   /* run fast if we are transferring files */
