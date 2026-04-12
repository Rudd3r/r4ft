# r4ft

Pre-built Docker images for AI coding agents. Built for r0mp 🦦

## Images

### Agent Images (CLI)
- `ghcr.io/rudd3r/r4ft:claude` — Anthropic Claude Code
- `ghcr.io/rudd3r/r4ft:codex` — OpenAI Codex
- `ghcr.io/rudd3r/r4ft:crush` — Charmbracelet Crush

### Computer Use Images (GUI Desktop)
- `ghcr.io/rudd3r/r4ft:computeruse-claude` — Claude with full desktop environment
- `ghcr.io/rudd3r/r4ft:computeruse-codex` — Codex with full desktop environment
- `ghcr.io/rudd3r/r4ft:computeruse-crush` — Crush with full desktop environment

The computer use variants include a 1920x1080 XFCE desktop, X11 display server, and MCP server for screenshot/input control.

## Build

```bash
make build-all          # Build all images
make agents             # Build CLI agents only
make computeruse        # Build computer use images only
make agents-claude      # Single agent image
make computeruse-codex  # Single computer use image
```

Images are tagged with both the model name and the git commit hash for version tracking.

## Usage

### CLI Agent
```bash
docker run --rm ghcr.io/rudd3r/r4ft:claude
```

### Computer Use Agent
```bash
docker run -it --rm \
    --name=computeruse \
    --privileged \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=America/Denver \
    -e TITLE=computeruse \
    -e SELKIES_MANUAL_WIDTH=1920 \
    -e SELKIES_MANUAL_HEIGHT=1080 \
    -e SELKIES_UI_SIDEBAR_SHOW_STATS=false \
    -e SELKIES_UI_SIDEBAR_SHOW_APPS=false \
    -e SELKIES_UI_SIDEBAR_SHOW_GAMEPADS=false \
    -e SELKIES_UI_SIDEBAR_SHOW_GAMING_MODE=false \
    -e SELKIES_UI_SIDEBAR_SHOW_TRACKPAD=false \
    -e SELKIES_AUDIO_ENABLED=false \
    -e SELKIES_MICROPHONE_ENABLED=false \
    -e SELKIES_GAMEPAD_ENABLED=false \
    -e MAX_RESOLUTION=1920x108 \
    -p ${RANDOM}:3001 \
    -v "${HOME}/.config/computeruse:/config" \
    --shm-size="1gb" \
    ghcr.io/rudd3r/r4ft:computeruse-claude
```

