#!/usr/bin/env bash
# Online/offline connectivity indicator for tmux statusbar

if ping -c1 -W2 1.1.1.1 >/dev/null 2>&1; then
  printf '#[fg=#{@thm_green}]󰖩 '
else
  printf '#[fg=#{@thm_red}]󰖪 '
fi
