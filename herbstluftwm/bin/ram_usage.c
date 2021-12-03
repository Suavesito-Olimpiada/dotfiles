#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MEM_TOTAL 1
#define MEM_USED 3
#define SWAP 16

int main(int argc, char *const argv[])
{
    int flags = 0;
    int c;
    while ((c = getopt(argc, argv, "stu")) != -1) {
        switch (c) {
            case 'u':
                flags = MEM_USED;
                break;
            case 't':
                if (flags != MEM_USED)
                    flags = MEM_TOTAL;
                break;
            case 's':
                if (flags == 0)
                    flags = SWAP;
                break;
        }
    }

    if (flags == 0) {
        fprintf(stderr, "A valid option \"[uts]\" must be set\n");
        return 1;
    }

    char path[] = "/proc/meminfo";
    FILE *fp = NULL;
    fp = fopen(path, "r");
    if (fp == NULL) {
        fprintf(stderr, "Not able to open \"%s\"\n", path);
        return 2;
    }

    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    long memtotal = -1;
    long memavailable = -1;
    long swaptotal = -1;
    long swapfree = -1;

    int i = 0;
    while ((read = getline(&line, &len, fp)) != -1 && (i < flags)) {
        switch (i) {
            case 0:
                sscanf(line, "%*s %ld ", &memtotal);
                break;
            case 2:
                sscanf(line, "%*s %ld ", &memavailable);
                break;
            case 14:
                sscanf(line, "%*s %ld ", &swaptotal);
                break;
            case 15:
                sscanf(line, "%*s %ld ", &swapfree);
                break;
        }
        free(line);
        line = NULL;
        len = 0;
        ++i;
    }

    if(len != 0)
        free(line);

    fclose(fp);

    switch (flags) {
        case MEM_TOTAL:
            if (memtotal != -1)
                printf("%.2lf GB", (double)(memtotal) / (double)(1 << 20));
            else
                puts("- GB");
            break;
        case MEM_USED:
            if (memtotal != -1 && memavailable != -1)
                printf("%.2lf GB",
                       (double)(memtotal - memavailable) / (double)(1 << 20));
            else
                puts("- GB");
            break;
        case SWAP:
            if (swapfree != -1 && swaptotal != -1) {
                if (swaptotal != swapfree)
                    printf("%.2lf GB",
                           (double)(swaptotal - swapfree) / (double)(1 << 20));
            }
            else {
                puts("- GB");
            }
            break;
    }

    fflush(stdout);

    return 0;
}
