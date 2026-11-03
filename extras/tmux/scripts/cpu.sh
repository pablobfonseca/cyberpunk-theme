#!/usr/bin/env bash
# CPU usage % with color-coded bar for tmux statusbar
# Output: tmux format string with @thm_* color references

get_cpu_mac() {
  # Must return well under 1s: tmux re-runs a #() job the moment it ends if it
  # ended in a later second than it started, so a slow reader loops nonstop.
  # top walks every thread (seconds under load); iostat needs a 1s sample.
  ps -A -o %cpu= 2>/dev/null | awk -v n="$(sysctl -n hw.ncpu)" '
    { s += $1 }
    END { printf "%.0f", s / n }
  '
}

get_cpu_linux() {
  # Read two snapshots 1s apart from /proc/stat
  read -r _ a1 b1 c1 d1 _ < /proc/stat
  sleep 1
  read -r _ a2 b2 c2 d2 _ < /proc/stat
  total=$(( (a2-a1) + (b2-b1) + (c2-c1) + (d2-d1) ))
  idle=$(( d2-d1 ))
  if [ "$total" -gt 0 ]; then
    printf '%d' $(( (total - idle) * 100 / total ))
  else
    printf '0'
  fi
}

case "$(uname -s)" in
  Darwin) cpu=$(get_cpu_mac) ;;
  Linux)  cpu=$(get_cpu_linux) ;;
  *)      cpu=0 ;;
esac

cpu=${cpu:-0}

# Color-coded bar: green <60, yellow 60-80, red >80
if [ "$cpu" -ge 80 ]; then
  color="#{@thm_red}"
  bar="████▓▒░"
elif [ "$cpu" -ge 60 ]; then
  color="#{@thm_yellow}"
  bar="██▓▒░"
else
  color="#{@thm_green}"
  bar="█▓▒░"
fi

printf '#[fg=%s]%s %s%%' "$color" "$bar" "$cpu"
