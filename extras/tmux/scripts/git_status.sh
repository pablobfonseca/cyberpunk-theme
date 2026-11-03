#!/usr/bin/env bash
# Git branch + dirty state for tmux statusbar
# Usage: git_status.sh /path/to/pane/cwd

cd "$1" 2>/dev/null || exit 0

# Not a git repo — output nothing
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
[ -z "$branch" ] && exit 0

# Count staged/unstaged changes; untracked files (??) count as additions.
# --no-optional-locks: a status bar must not write the index under an editor
added=0; modified=0
while IFS= read -r line; do
  idx="${line:0:1}"
  wt="${line:1:1}"
  case "$idx" in
    [AMRC?]) added=$((added + 1)) ;;
  esac
  case "$wt" in
    [AMRCD]) modified=$((modified + 1)) ;;
  esac
done < <(git --no-optional-locks status --porcelain 2>/dev/null)

# Build output — includes leading separator so it vanishes when not in a repo
out="#[fg=#{@thm_green},dim] │ #[none]#[fg=#{@thm_green}]󰊢 ${branch}"
[ "$added" -gt 0 ] && out="${out} #[fg=#{@thm_yellow}]+${added}"
[ "$modified" -gt 0 ] && out="${out} #[fg=#{@thm_pink}]~${modified}"

printf '%s' "$out"
