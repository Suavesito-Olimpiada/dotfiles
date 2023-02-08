#!/usr/bin/env sh
#NO LONGER ACTIVE

#stop processes on kill
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

BIN="$HOME/.config/herbstluftwm/bin"

_Workspaces() {
        curr=$("$BIN"/wmdesk)
        printf "%s" "$("$BIN"/wmdesk -a)" | sed -e "s/$curr/%{R} $curr %{R}/"
}

_Modules() {
        while true; do
                echo "S:$(iwgetid -r || printf '%s' 'Disconnected')"
                echo "T:$("$BIN"/time &)"
                sleep 3
        done
}

_SysInfoModule() {
        while true; do
                echo "C:$("$BIN"/cpu_usage &)"
                echo "R:$("$BIN"/ram_usage -u &)"
                sleep 1;
        done
}

# Battery can be updated every five seconds, no battery drains that fast.
_BatModule() {
        while true; do
            echo "B:$("$BIN"/battery -n &)"
            sleep 5;
        done
}
# Volume module. This needs to be updated constantly to reflect the current vol.
_VolModule() {
        while true; do
        echo "V:$(volume.sh get&)"
        sleep 0.2;
        done
}

_Wininfo() {
        leftwm-state | while read -r line; do
                echo "W:$("$BIN"/wmtitle | colrm 40)"
                echo "K:$(_Workspaces &)"
        done
}

lemon_fifo="/tmp/lemonfifo"

[ -e "$lemon_fifo" ] && rm "$lemon_fifo"
mkfifo "$lemon_fifo"

_VolModule > "$lemon_fifo" &
_BatModule > "$lemon_fifo" &
_SysInfoModule > "$lemon_fifo" &
_Modules > "$lemon_fifo" &
_Wininfo > "$lemon_fifo" &

_Main() {
        while read -r report; do
                case $report in
                        B*) batt="$(echo "${report##*:}")";;
                        C*) cpu="$(echo "${report##*:}")";;
                        K*) wm="$(echo "${report##*:}")";;
                        R*) ram="$(echo "${report##*:}")";;
                        S*) ssid="$(echo "${report##*:}")";;
                        T*) time="$(echo "$report" | cut -d':' -f2-)";;
                        V*) vol="$(echo "${report##*:}")";;
                        W*) wname="$(echo "${report##*:}")";;
                esac
                sleep 0.1s
                printf "%s" "%{F#FAFAFA}%{R} $wm %{R} $wname... %{r}%{B#282c34}%{F#E06c75}%{R}%{F#282c34} 龍 cpu: $cpu %{F#E5C07B}%{B#E06c75}%{R}%{F#282c34}  ram: $ram %{B#E5C07B}%{F#61AFEF}%{R}%{F#282c34}  $time %{B#61AFEF}%{F#98C379}%{R}%{F#282c34}  $batt %{B#98C379}%{F#DA8548}%{R}%{F#282c34} 墳 $vol %{B#DA8548}%{F#c678dd}%{R}%{F#282c34}  $ssid %{B#282c34}"
        done
}

_Main < "$lemon_fifo"

