#!/usr/bin/env bash
# Memory usage in human-readable units for tmux statusbar

get_mem_mac() {
  page_size=$(sysctl -n hw.pagesize 2>/dev/null || echo 4096)
  # vm_stat outputs pages; we want "Pages active" + "Pages wired down"
  vm_stat 2>/dev/null | awk -v ps="$page_size" '
    /Pages active/ { active = $NF + 0 }
    /Pages wired/  { wired  = $NF + 0 }
    END {
      bytes = (active + wired) * ps
      gb = bytes / 1073741824
      if (gb >= 1) printf "%.1fG", gb
      else printf "%dM", bytes / 1048576
    }
  '
}

get_mem_linux() {
  awk '
    /MemTotal/     { total = $2 }
    /MemAvailable/ { avail = $2 }
    END {
      used = total - avail
      gb = used / 1048576
      if (gb >= 1) printf "%.1fG", gb
      else printf "%dM", used / 1024
    }
  ' /proc/meminfo
}

case "$(uname -s)" in
  Darwin) mem=$(get_mem_mac) ;;
  Linux)  mem=$(get_mem_linux) ;;
  *)      mem="?" ;;
esac

# Color: extract numeric value for thresholds
num=$(echo "$mem" | sed 's/[^0-9.]//g')
unit=$(echo "$mem" | sed 's/[0-9.]//g')

if [ "$unit" = "G" ]; then
  # >8G red, >4G yellow, else green
  if awk "BEGIN{exit(!($num >= 8))}"; then
    color="#{@thm_red}"
  elif awk "BEGIN{exit(!($num >= 4))}"; then
    color="#{@thm_yellow}"
  else
    color="#{@thm_green}"
  fi
else
  color="#{@thm_green}"
fi

printf '#[fg=%s]󰍛 %s' "$color" "$mem"
