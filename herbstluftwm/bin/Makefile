CC          = gcc

LIBNOTIFY   = `pkg-config --cflags --libs libnotify`

.PHONY: all
all: battery batteryd cpu_usage ram_usage time wmdesk wmtitle

.PHONY: clean
clean:
	rm battery cpu_usage ram_usage time wmdesk wmtitle

battery:
	$(CC) -o battery -O2 $(LIBNOTIFY) battery.c

batteryd:
	$(CC) -o batteryd -O2 $(LIBNOTIFY) batteryd.c

cpu_usage:
	$(CC) -o cpu_usage -O2 cpu_usage.c

ram_usage:
	$(CC) -o ram_usage -O2 ram_usage.c

time:
	$(CC) -o time -O2 time.c

wmdesk:
	$(CC) -o wmdesk -O2 wmdesk.c `pkg-config --cflags --libs x11`

wmtitle:
	$(CC) -o wmtitle -O2 wmtitle.c `pkg-config --cflags --libs x11`
