/* gcc -O2 `pkg-config --cflags --libs libnotify` -o battery battery.c */

#define _GNU_SOURCE
#include <ctype.h>
#include <libnotify/notify.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define BAT_energy_NOW 0x1
#define BAT_STATUS 0x2

static float battery_energy_now()
{
    size_t len = 0;
    char *line = NULL;

    long energy_now = -1;
    char energy_now_path[] = "/sys/class/power_supply/BAT0/energy_now";
    FILE *BAT_energy_now_fp = NULL;

    long energy_full = -1;
    char energy_full_path[] = "/sys/class/power_supply/BAT0/energy_full";
    FILE *BAT_energy_full_fp = NULL;

    BAT_energy_now_fp = fopen(energy_now_path, "r");
    if (BAT_energy_now_fp == NULL) {
        fprintf(stderr, "Not able to open \"%s\"\n", energy_now_path);
        return 0.0;
    }

    if (getline(&line, &len, BAT_energy_now_fp) != -1) {
        sscanf(line, "%ld ", &energy_now);
        free(line);
    }

    fclose(BAT_energy_now_fp);

    if (energy_now == -1)
        return -1.0;

    BAT_energy_full_fp = fopen(energy_full_path, "r");
    if (BAT_energy_full_fp == NULL) {
        fprintf(stderr, "Not able to open \"%s\"\n", energy_full_path);
        return 0.0;
    }

    line = NULL;
    len = 0;
    if (getline(&line, &len, BAT_energy_full_fp) != -1) {
        sscanf(line, "%ld ", &energy_full);
        free(line);
    }

    fclose(BAT_energy_full_fp);

    if (energy_full == -1)
        return -1.0;

    if (energy_full != 0)
        return (double)(100 * energy_now) / (double)energy_full;

    return 0.0;
}

static char *battery_status()
{
    size_t len = 0;
    char *line = NULL;

    char status_path[] = "/sys/class/power_supply/BAT0/status";
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
                flags = BAT_energy_NOW;
                break;
            case 's':
                if (flags != BAT_energy_NOW)
                    flags = BAT_STATUS;
                break;
        }
    }

    char *status;
    float charge;
    switch (flags) {
        case BAT_energy_NOW:
            charge = battery_energy_now();
            printf("%.2f%%", charge);
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