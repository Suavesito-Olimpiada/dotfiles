#include <stdio.h>
#include <string.h>
#include <time.h>

#define BUF_LEN 256

int main()
{
    char buf[BUF_LEN] = {0};
    time_t rawtime = time(NULL);
    struct tm *ptm = localtime(&rawtime);

    if (rawtime == -1) {
        puts("The time() function failed");
        return 1;
    }

    if (ptm == NULL) {
        puts("The localtime() function failed");
        return 1;
    }

    strftime(buf, BUF_LEN-1, "%H:%M %d/%m/%Y", ptm);
    printf("%s", buf);

    return 0;
}
