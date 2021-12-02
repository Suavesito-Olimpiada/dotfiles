#define _GNU_SOURCE
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    size_t len = -1;
    char *line = NULL;

    bool got_now = false;
    unsigned long charge_now = 0;
    char charge_now_path[] = "/sys/class/power_supply/BAT1/charge_now";
    FILE *BAT_charge_now_fp = NULL;

    bool got_full = false;
    unsigned long charge_full = 0;
    char charge_full_path[] = "/sys/class/power_supply/BAT1/charge_full";
    FILE *BAT_charge_full_fp = NULL;

    char status_path[] = "/sys/class/power_supply/BAT1/status";
    FILE *BAT_status_fp = NULL;

    BAT_charge_now_fp = fopen(charge_now_path, "r");
    if (!BAT_charge_now_fp) {
        fprintf(stderr, "Not able to open \"%s\"\n", charge_now_path);
    }
    else {
        if (getline(&line, &len, BAT_charge_now_fp) != -1) {
            if (sscanf(line, "%lu ", &charge_now) == 1)
                got_now = true;
            free(line);
            line = NULL;
            len = 0;
        }
        fclose(BAT_charge_now_fp);
    }

    if (!got_now)
        goto status;

    BAT_charge_full_fp = fopen(charge_full_path, "r");
    if (!BAT_charge_full_fp)
        fprintf(stderr, "Not able to open \"%s\"\n", charge_full_path);
    else {
        if (getline(&line, &len, BAT_charge_full_fp) != -1) {
            if (sscanf(line, "%lu ", &charge_full) == 1)
                got_full = true;
            free(line);
            line = NULL;
            len = 0;
        }
        fclose(BAT_charge_full_fp);
    }

status:

    if (got_full && got_now)
        printf(charge_now ? "%.02lu%%\n" : "%lu%%\n",
               charge_full ? (100 * charge_now) / charge_full : 0);
    else
        printf(" -%%\n");

    BAT_status_fp = fopen(status_path, "r");
    if (!BAT_status_fp) {
        fprintf(stderr, "Not able to open \"%s\"\n", status_path);
        printf("Unknown\n");
    }
    else {
        if (getline(&line, &len, BAT_status_fp) != -1) {
            for (unsigned long i = 0; i < len; ++i)
                if (!isalpha(line[i])) {
                    line[i] = '\0';
                    break;
                }
            printf("%s\n", line);
            free(line);
        }
        fclose(BAT_status_fp);
    }

    return 0;
}
