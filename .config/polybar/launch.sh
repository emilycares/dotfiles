#!/bin/bash
killall -q polybar

# wait until closed
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/config.ini top &
polybar -c ~/.config/polybar/config.ini top2 &

