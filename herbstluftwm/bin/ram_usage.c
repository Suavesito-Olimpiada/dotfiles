#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main()
{
    char path[] = "/proc/meminfo";
    FILE *fp = NULL;
    fp = fopen(path, "r");
    if (!fp) {
        fprintf(stderr, "Not able to open \"%s\"\n", path);
        printf("Unknown");
        return 1;
    }

    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    unsigned long total = 0;
    unsigned long available = 0;

    for (int i = 0; i < 3; i++) {
        line = NULL;
        len = 0;
        if ((read = getline(&line, &len, fp)) != -1) {
            if (i == 0) {
                sscanf(line, "%*s %lu ", &total);
            }
            else if (i == 2) {
                sscanf(line, "%*s %lu ", &available);
            }
            free(line);
        }
    }

    printf("%.2lf GB\n", (double)(total - available) / (double)(1 << 20));
    printf("%.2lf GB", (double)(total) / (double)(1 << 20));

    fclose(fp);

    return 0;
}
