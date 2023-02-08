#!/usr/bin/env bash

quote() {
	local q="$(printf '%q ' "$@")"
	printf '%s' "${q% }"
}

if [[ -f /usr/lib/bash/sleep ]]; then
    # load and enable 'sleep' builtin (does not support unit suffixes: h, m, s!)
    # requires pkg 'bash-builtins' on debian; included in 'bash' on arch.
    enable -f /usr/lib/bash/sleep sleep
fi

hc_quoted="$(quote "${herbstclient_command[@]:-herbstclient}")"
hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(hc monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=16
#font="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
#font="-*-notosansmono nerd font-medium-*-*-*-8-*-*-*-*-*-*-*" # xfontsel
font="Noto Sans Mono CJK KR,Noto Sans Mono CJK HK,Noto Sans Mono CJK JP,Noto Sans Mono CJK SC,Noto Sans Mono CJK TC:style=Medium:size=8"
# extract colors from hlwm and omit alpha-value
bgcolor=$(hc get frame_border_normal_color|sed 's,^\(\#[0-9a-f]\{6\}\)[0-9a-f]\{2\}$,\1,')
selbg=$(hc get window_border_active_color|sed 's,^\(\#[0-9a-f]\{6\}\)[0-9a-f]\{2\}$,\1,')
#selfg='#101010'
selfg='#EEEEEE'

####
# Try to find textwidth binary.
# In e.g. Ubuntu, this is named dzen2-textwidth.
if which xftwidth &> /dev/null ; then
    textwidth="xftwidth";
elif which dzen2-textwidth &> /dev/null ; then
    textwidth="dzen2-textwidth";
elif which textwidth &> /dev/null ; then # For guix
    textwidth="textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi
####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

hc pad $monitor $panel_height

{
    ### Event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this generates events, formed like this:
    #   <eventname>\t<data> [...]
    # e.g.
    #   date    ^fg(#efefef)18:33^fg(#909090), 2013-10-^fg(#efefef)29

    #mpc idleloop player &
    while true ; do
        # output is checked once a second, but a "date" event is only
        # generated if the output changed compared to the previous run.
        printf 'date\t^fg(#efefef)%(%H:%M)T^fg(#909090), %(%Y-%m)T-^fg(#efefef)%(%d)T\n'
        sleep 1 || break
    done > >(uniq_linebuffered) &

    while true ; do
        "$HOME/.config/herbstluftwm/bin/cpu_usage" 1
        playerctl metadata --format '{{title}} ({{artist}})'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    date=""
    windowtitle=""
    while true ; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        separator="^bg()^fg($selbg)|"
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg($selbg)^fg($selfg)"
                    ;;
                '+')
                    echo -n "^bg(#9CA668)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg()^fg(#ffffff)"
                    ;;
                '!')
                    echo -n "^bg(#FF0675)^fg(#141414)"
                    ;;
                *)
                    echo -n "^bg()^fg(#ababab)"
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ] ; then
                # clickable tags if using SVN dzen
                echo -n "^ca(1,$hc_quoted focus_monitor \"$monitor\" && "
                echo -n "$hc_quoted use \"${i:1}\") ${i:1} ^ca()"
            else
                # non-clickable tags if using older dzen
                echo -n " ${i:1} "
            fi
        done
        echo -n "$separator"
        echo -n "^bg()^fg() ${windowtitle//^/^^}"
        # small adjustments
        #right="$separator^bg() $date $separator"

        color='#43AAFF'
        color2='#FF0000'

        BIN="$HOME/.config/herbstluftwm/bin"
        # CPU
        cpu=$("$BIN"/cpu_usage 1)
        # RAM
        usd=$("$BIN"/ram_usage -u)
        tot=$("$BIN"/ram_usage -t)
        swp=$("$BIN"/ram_usage -s)
        # BATTERY
        bat=$("$BIN"/battery -n)
        sta=$("$BIN"/battery -s)
        # SCREEN
        lig=$(light | cut -d'.' -f1)
        # VOLUME
        vol=$(amixer -D pulse get Master | sed -En '7,7s/.* \[(.*)\] .*/\1/p')
        # MUSIC
        msc=$(playerctl metadata -f '{{artist}} - {{title}}' | colrm 40)

        right="$separator^bg($hintcolor)\
 ^fg($color)MUSIC: ^fg()$msc $separator^bg($hintcolor)\
 ^fg($color)VOL: ^fg()$vol $separator^bg($hintcolor)\
 ^fg($color)LIG: ^fg()$lig $separator^bg($hintcolor)\
 ^fg($color)BAT: ^fg()$bat ^fg($color)-^fg() $sta  $separator^bg($hintcolor)\
 ^fg($color)RAM: ^fg()$usd^fg($color):^fg($color2)$swp^fg($color)/^fg()$tot $separator^bg($hintcolor)\
 ^fg($color)CPU: ^fg()$cpu $separator^bg($hintcolor)\
 $date $separator"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space..
        width=$($textwidth "$font" "$right_text_only    ")
        echo -n "^pa($(($panel_width - $width)))$right"
        echo

        ### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "Special" events (quit_panel/togglehidepanel/reload) are also handled
        # here.

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                #echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(hc list_monitors | sed -n '/\[FOCUS\]$/s/:.*//p')
                if [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    hc pad $monitor 0
                else
                    visible=true
                    hc pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            #player)
            #    ;;
        esac
    done

    ### dzen2 ###
    # After the data is gathered and processed, the output of the previous block
    # gets piped to dzen2.

} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -e "button3=;button4=exec:$hc_quoted use_index -1;button5=exec:$hc_quoted use_index +1" \
    -ta l -bg "$bgcolor" -fg '#efefef'
