/* gcc -O2 `pkg-config --cflags --libs libnotify` -o battery battery.c */

#define _GNU_SOURCE
#include <ctype.h>
#include <libnotify/notify.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

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

static void battery_notify(const float charge, const char *const status)
{
    if (!status)
        return;

    const float min = 60.0f;
    const float max = 99.5f;

    /* reminder that `strcmp` returns `0` when both strings are equal */
    if ((charge > min && charge < max) ||
        (charge > max && strcmp(status, "Discharging") == 0) ||
        (charge < min && strcmp(status, "Charging") == 0))
        return;

    if (!notify_init("Battery"))
        return;

    char *icon = NULL;
    char *summary = NULL;
    char *message = NULL;

    if (charge > max) {
        icon =
            "file:///usr/share/icons/la-capitaine/status/scalable-dark/"
            "battery-full-charged.svg";
        summary = "Battery full";
        message = "Disconnect power cord";
    }
    else if (charge < min) {
        icon =
            "file:///usr/share/icons/la-capitaine/status/scalable-dark/"
            "battery-good.svg";
        summary = "Battery discharging";
        message = "Connect power cord";
    }

    NotifyNotification *notification =
        notify_notification_new(summary, message, icon);

    if (notification) {
        /* NOTIFY_URGENCY_LOW, NOTIFY_URGENCY_NORMAL, NOTIFY_URGENCY_CRITICAL */
        notify_notification_set_urgency(notification, NOTIFY_URGENCY_CRITICAL);

        notify_notification_show(notification, NULL);

        g_object_unref(G_OBJECT(notification));
    }

    notify_uninit();
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

int main()
{
    char *status;
    float charge;
    while (true) {
        charge = battery_energy_now();
        status = battery_status();
        battery_notify(charge, status);
        free(status);
        sleep(60);
    }

    return 0;
}
