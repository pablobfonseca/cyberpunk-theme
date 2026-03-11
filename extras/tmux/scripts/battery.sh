#!/usr/bin/env bash
# Battery % with icon for tmux statusbar

get_battery_mac() {
  pmset -g batt 2>/dev/null | awk '
    /InternalBattery/ {
      gsub(/;/, "")
      gsub(/%/, "")
      pct = $3
      status = "discharging"
      if (/charging/)    status = "charging"
      if (/charged/)     status = "full"
      if (/AC attached/) status = "charging"
      print pct, status
    }
  '
}

get_battery_linux() {
  for bat in /sys/class/power_supply/BAT*; do
    [ -f "$bat/capacity" ] || continue
    pct=$(cat "$bat/capacity")
    raw=$(cat "$bat/status" 2>/dev/null)
    case "$raw" in
      Charging)                status="charging" ;;
      Full|"Not charging")    status="full" ;;
      *)                      status="discharging" ;;
    esac
    echo "$pct $status"
    return
  done
}

case "$(uname -s)" in
  Darwin) read -r pct state <<< "$(get_battery_mac)" ;;
  Linux)  read -r pct state <<< "$(get_battery_linux)" ;;
  *)      pct="" ;;
esac

# No battery found — output nothing
[ -z "$pct" ] && exit 0

# Icon + color based on charging state and level
if [ "$state" = "full" ] || { [ "$state" = "charging" ] && [ "$pct" -eq 100 ]; }; then
  icon="󰁹"; color="#{@thm_green}"
elif [ "$state" = "charging" ]; then
  icon="󰂄"; color="#{@thm_cyan}"
elif [ "$pct" -ge 80 ]; then
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

printf '#[fg=%s]%s %s%%' "$color" "$icon" "$pct"
