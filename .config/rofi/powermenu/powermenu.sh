#!/usr/bin/env bash

dir="~/.config/rofi/styles/"
rofi_command="rofi -theme ~/.config/rofi/powermenu/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$($HOME/.config/rofi/utilities/usedcpu.sh)
memory=$($HOME/.config/rofi/utilities/usedram.sh)

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		betterlockscreen --lock
        ;;
    $suspend)
        betterlockscreen --suspend
        ;;
    $logout)
		bspc quit
        ;;
esac
