#!/usr/bin/env bash

xset 120 5
xset r rate 300 25
xss-lock -l -- '~/.config/script/lock_screen' &!
autocutsel -fork &!
autocutsel -selection PRIMARY -fork &! #Makes cut and paste behave as expected
mpd &> /dev/null &!
/usr/lib/kdeconnectd&!
dunst -config '~/.config/dunst/dunstrc' &!
# /usr/lib/notify-osd/notify-osd &!
# blueman-applet &!
compton --config '~/.config/compton/compton.conf' &!
'~/Apps/precompile/lifecalendar/lifecalendar.py' -c '~/Apps/precompile/lifecalendar/examples/default.cfg' -o '~/Apps/precompile/lifecalendar/BgLifetime.png'
feh --bg-fill --no-fehbg '~/Apps/precompile/lifecalendar/BgLifetime.png'
setxkbmap latam
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient PalmDetect=1
numlockx on

'~/.config/herbstluftwm/panel_var.sh' &!

cd '~/.dotfiles/installed/'

pacman -Q > packages.system
pip2 freeze --local > py2ckages.system
pip3 freeze --local > py3ckages.system
gem list > gemckages.system
npm list > npmackages.system
julia -e 'print(Pkg.installed())' | sed 's/,/\n/g' > juliackges.system

git add packages.system py2ckages.system py3ckages.system gemckages.system npmackages.system juliackges.system
git commit -m "Updating .system files ($(date '+%H:%M %d-%m-%y'))"
git push -u origin master
