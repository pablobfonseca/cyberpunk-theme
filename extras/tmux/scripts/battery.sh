#!/usr/bin/env bash
# Battery % with icon for tmux statusbar

get_battery_mac() {
  pmset -g batt 2>/dev/null | awk '
    /InternalBattery/ {
      gsub(/;/, "")
      gsub(/%/, "")
      print $3
    }
  '
}

get_battery_linux() {
  for bat in /sys/class/power_supply/BAT*; do
    [ -f "$bat/capacity" ] && cat "$bat/capacity" && return
  done
}

case "$(uname -s)" in
  Darwin) pct=$(get_battery_mac) ;;
  Linux)  pct=$(get_battery_linux) ;;
  *)      pct="" ;;
esac

# No battery found — output nothing
[ -z "$pct" ] && exit 0

# Icon + color based on charge level
if [ "$pct" -ge 80 ]; then
  icon="󰁹"; color="#{@thm_green}"
elif [ "$pct" -ge 60 ]; then
  icon="󰂀"; color="#{@thm_green}"
elif [ "$pct" -ge 40 ]; then
  icon="󰁾"; color="#{@thm_yellow}"
elif [ "$pct" -ge 20 ]; then
  icon="󰁻"; color="#{@thm_yellow}"
else
  icon="󰁺"; color="#{@thm_red}"
fi

printf '#[fg=%s]%s %s%%%%' "$color" "$icon" "$pct"
