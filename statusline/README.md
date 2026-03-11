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

### Enabling git branch

Add `--git` to the command:

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y @pablobfonseca/claude-cyberpunk-powerline --style=storm --git"
  }
}
```

Git branch is cached for 5 seconds to avoid performance overhead.

## Segments

| Segment | Color | Condition |
|---------|-------|-----------|
| Model name | neon cyan | Always shown |
| Context bar | cyan → green → yellow → orange → pink | Color shifts as context fills |
| Session cost | neon purple | Always shown |
| Lines changed | green (+) / pink (-) | Hidden when both are 0 |
| Git branch | neon blue | Only with `--git` flag |

## Requirements

- Node.js >= 18
- A terminal with true-color (24-bit) support
