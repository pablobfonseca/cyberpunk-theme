# claude-cyberpunk-powerline

Cyberpunk-themed statusline for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). True-color ANSI output with three style variants matching [cyberpunk-theme](https://github.com/pablobfonseca/cyberpunk-theme) for Neovim.

```
⟨Opus⟩ │ ████░░░░░░ 42% │ $1.23 │ +156 -34
```

## Setup

Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y @pablobfonseca/claude-cyberpunk-powerline --style=storm"
  }
}
```

## Styles

| Flag | Description |
|------|-------------|
| `--style=storm` | Default — vibrant neon on dark blue-gray |
| `--style=night` | Muted accents, deeper backgrounds |
| `--style=neon` | Maximum saturation, pure black background |

## Options

| Flag | Description |
|------|-------------|
| `--git` | Show current git branch |
| `--duration` | Show session wall time and API wait time |
| `--cache` | Show prompt cache hit ratio |
| `--vim-mode` | Show Claude's vim mode (NORMAL/INSERT) |

All options are disabled by default. Combine as needed:

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y @pablobfonseca/claude-cyberpunk-powerline --style=storm --git --duration --cache --vim-mode"
  }
}
```

Git branch is cached for 5 seconds to avoid performance overhead.

## Segments

| Segment | Color | Condition |
|---------|-------|-----------|
| Vim mode | blue (NORMAL) / green (INSERT) | Only with `--vim-mode` flag |
| Project name | neon blue | Always shown |
| Model name | neon cyan | Always shown |
| Context bar | cyan → green → yellow → orange → pink | Color shifts as context fills |
| Token count | neon yellow | Hidden when 0 |
| Session cost | neon purple | Always shown |
| Lines changed | green (+) / pink (-) | Hidden when both are 0 |
| Git branch | neon blue | Only with `--git` flag |
| Duration | neon cyan + dim API time | Only with `--duration` flag |
| Cache ratio | green (≥70%) / yellow (≥40%) / orange (<40%) | Only with `--cache` flag |

## Requirements

- Node.js >= 18
- A terminal with true-color (24-bit) support
