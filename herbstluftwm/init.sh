#!/usr/bin/env bash

xhost + # Allow connectinos from all hosts, (for X apps in docker to work)
xset s 120 5
xset r rate 300 30
xss-lock -l -- "$HOME/.config/scripts/screen/lock.sh" &!
redshift &!
autocutsel -fork &!
autocutsel -selection PRIMARY -fork &! #Makes cut and paste behave as expected
mpd &> /dev/null &> /dev/null && mpd-mpris &> /dev/null &!
/usr/lib/kdeconnectd&!
dunst -config "$HOME/.config/dunst/dunstrc" &!
# /usr/lib/notify-osd/notify-osd &!
picom &!
"$HOME/Apps/precompile/lifecalendar/lifecalendar.py" -c "$HOME/Apps/precompile/lifecalendar/examples/default.cfg" -o "$HOME/Apps/precompile/lifecalendar/BgLifetime.png"
feh --bg-fill --no-fehbg "$HOME/Apps/precompile/lifecalendar/BgLifetime.png"
setxkbmap latam -option caps:escape
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient PalmDetect=1
numlockx on

"$HOME/.config/herbstluftwm/panel_var.sh" &!

exit

cd "$HOME/.dotfiles/installed/"

pacman -Qqet > packages.system
pacman -Qqemt > packages_foreign.system
pacman -Qqent > packages_native.system
pip2 freeze --local > py2ckages.system
pip3 freeze --local > py3ckages.system
gem list > gemckages.system
npm list > npmackages.system
julia -e 'using Pkg; println(Pkg.installed())' | sed -e 's/Dict{String,Union{Nothing, VersionNumber}}(//' -e 's/,/\n/g' -e 's/)//' > juliackges.system

git add packages.system py2ckages.system py3ckages.system gemckages.system npmackages.system juliackges.system
git commit -m "Updating .system files ($(date '+%H:%M %d-%m-%y'))"
git push -u origin master
