#define _GNU_SOURCE
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BAT_CHARGE_NOW 0x1
#define BAT_STATUS 0x2

static float battery_charge_now()
{
    size_t len = 0;
    char *line = NULL;

    long charge_now = -1;
    char charge_now_path[] = "/sys/class/power_supply/BAT1/charge_now";
    FILE *BAT_charge_now_fp = NULL;

    long charge_full = -1;
    char charge_full_path[] = "/sys/class/power_supply/BAT1/charge_full";
    FILE *BAT_charge_full_fp = NULL;

    BAT_charge_now_fp = fopen(charge_now_path, "r");
    if (BAT_charge_now_fp == NULL) {
        fprintf(stderr, "Not able to open \"%s\"\n", charge_now_path);
        return 0.0;
    }

    if (getline(&line, &len, BAT_charge_now_fp) != -1) {
        sscanf(line, "%ld ", &charge_now);
        free(line);
    }

    fclose(BAT_charge_now_fp);

    if (charge_now == -1)
        return -1.0;

    BAT_charge_full_fp = fopen(charge_full_path, "r");
    if (BAT_charge_full_fp == NULL) {
        fprintf(stderr, "Not able to open \"%s\"\n", charge_full_path);
        return 0.0;
    }

    line = NULL;
    len = 0;
    if (getline(&line, &len, BAT_charge_full_fp) != -1) {
        sscanf(line, "%ld ", &charge_full);
        free(line);
    }

    fclose(BAT_charge_full_fp);

    if (charge_full == -1)
        return -1.0;

    if (charge_full != 0)
        return (double)(100 * charge_now) / (double)charge_full;

    return 0.0;
}

static char *battery_status()
{
    size_t len = 0;
    char *line = NULL;

    char status_path[] = "/sys/class/power_supply/BAT1/status";
    FILE *BAT_status_fp = NULL;

    BAT_status_fp = fopen(status_path, "r");
    if (!BAT_status_fp) {
        fprintf(stderr, "Not able to open \"%s\"\n", status_path);
        return NULL;
    }

    if (getline(&line, &len, BAT_status_fp) != -1) {
        for (unsigned long i = 0; i < len; ++i)
            if (!isalpha(line[i])) {
                line[i] = '\0';
                break;
            }
    }

    fclose(BAT_status_fp);

    return line;
}

int main(int argc, char *const argv[])
{
    int flags = 0;
    int c;
    while ((c = getopt(argc, argv, "sn")) != -1) {
        switch (c) {
            case 'n':
                flags = BAT_CHARGE_NOW;
                break;
            case 's':
                if (flags != BAT_CHARGE_NOW)
                    flags = BAT_STATUS;
                break;
        }
    }

    char *status;
    switch (flags) {
        case BAT_CHARGE_NOW:
            printf("%.2f%%", battery_charge_now());
            break;
        case BAT_STATUS:
            status = battery_status();
            if (status == NULL) {
                fputs("Unkown", stdout);
            }
            else {
                fputs(status, stdout);
                free(status);
            }
            break;
    }

    return 0;
}
