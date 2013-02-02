#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <grp.h>

void xdie(const char *s) {
	printf("%s\n", s);
	exit(1);
}


int main(int argc,const char *const *argv) {
	gid_t grlist[1];
	
	if(argc < 5) {
		xdie("usage: ugexec UID GID INT_UMASK COMMAND");
	}
	grlist[0] = atoi(argv[2]);
	
	if( setgroups(1, grlist) == -1)
		xdie("setgroups failed");
	
	if( setgid(grlist[0]) == -1)
		xdie("setgid failed");
	
	if(setuid(atoi(argv[1])) == -1)
		xdie("setuid failed");
	
	umask(atoi(argv[3]));
	
	execv(argv[4], &argv[4]);
	
	/* not reached */
	exit(1);
}
