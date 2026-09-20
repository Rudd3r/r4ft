# Computer Use Docker Images

Pre-built Docker images for AI agents with full desktop environment and computer use capabilities via MCP (Model Context Protocol).

## Overview

These images provide a complete desktop environment (XFCE on LinuxServer's webtop base) with:
- 1920x1080 X11 display accessible via web browser
- X11-computer-use-mcp server for screenshot and input control
- Pre-installed AI coding agents (Claude, Codex, Pi, OpenHands, Crush, Ajent, Opencode)
- OpenVSCode Server for web-based VS Code access
- Development tools: Go, Node.js, Python, tmux, vim, and more

## Available Images

| Image Tag | Agent | Description |
|-----------|-------|-------------|
| `computeruse-claude` | Anthropic Claude Code | CLI agent with desktop environment |
| `computeruse-pi` | Earendil Pi | Pi coding agent with desktop environment |
| `computeruse-openhands` | OpenHands | OpenHands agent with desktop environment |
| `computeruse-codex` | OpenAI Codex | CLI agent with desktop environment |
| `computeruse-crush` | Charmbracelet Crush | CLI agent with desktop environment |
| `computeruse-ajent` | Ajent | CLI agent with desktop environment |
| `computeruse-opencode` | Opencode AI | CLI agent with desktop environment |
| `computeruse-*-openvscode` | Any agent + VS Code | All above variants with OpenVSCode Server |

Images are available at: `ghcr.io/rudd3r/r4ft:<tag>`

## Quick Start

### Basic Usage

```bash
docker run -it --rm \
    --name computeruse \
    --privileged \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=America/Denver \
    -p 3001:3001 \
    -v "${HOME}/.config/computeruse:/config" \
    --shm-size="1gb" \
    ghcr.io/rudd3r/r4ft:computeruse-claude
```

Access the desktop:
- **Web Desktop**: Open `http://localhost:3001` in your browser
- **OpenVSCode**: Open `http://localhost:3535` (for *-openvscode variants)

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PUID` | 1000 | User ID |
| `PGID` | 1000 | Group ID |
| `TZ` | America/Denver | Timezone |
| `TITLE` | Agent Computer Use | Browser tab title |
| `MAX_RESOLUTION` | 1920x1080 | Maximum display resolution |
| `DISABLE_ZINK` | false | Disable Nvidia/Zink GPU support |

## Computer Use MCP Server

The `x11-computer-use-mcp` binary provides an MCP server that enables AI agents to control the desktop environment. It uses pyautogui for input and python-xlib + Pillow for screenshots.

### MCP Tools

#### Screenshot Tools

| Tool | Description |
|------|-------------|
| `screenshot(save_path?)` | Capture full screen (1920x1080) |
| `screenshot_grid(spacing=100, save_path?)` | Full screen with coordinate grid overlay |
| `screenshot_region(x, y, width, height, scale=2, save_path?)` | Capture and magnify a region |
| `screenshot_window(window_id, save_path?)` | Capture a specific window |
| `get_screen_size()` | Return screen dimensions |
| `list_windows()` | List all managed windows with IDs and geometry |

#### Input Tools

| Tool | Description |
|------|-------------|
| `click(x, y, button="left")` | Click at coordinates |
| `double_click(x, y)` | Double-click at coordinates |
| `drag(from_x, from_y, to_x, to_y)` | Drag from one point to another |
| `mouse_move(x, y)` | Move mouse to coordinates |
| `mouse_down(x, y, button="left")` | Press mouse button |
| `mouse_up(x, y, button="left")` | Release mouse button |
| `scroll(x, y, delta_x, delta_y)` | Scroll at coordinates |
| `type_text(text, delay=50)` | Type text with ms delay between keystrokes |
| `key_down(key)` | Press key down |
| `key_up(key)` | Release key |
| `key_press(key)` | Press and release key or combo (e.g., "ctrl+c") |
| `activate_window(window_id)` | Focus a window by ID |

### Using the MCP with AI Agents

#### With Claude Code

```bash
# Start the MCP server
x11-computer-use-mcp

# In another terminal, run Claude with MCP
claude --mcp-server x11-computer-use-mcp
```

#### With OpenHands

```bash
# OpenHands can be configured to use MCP servers
# Add to your OpenHands configuration:
openhands --mcp-server x11-computer-use-mcp
```

### Coordinate System

**Important**: All coordinates are in **actual screen pixels** (1920x1080), not scaled display pixels.

When viewing screenshots:
1. Use `screenshot_grid()` to get a labelled overview with coordinate grid
2. Read the grid labels to find accurate coordinates
3. Use `screenshot_region()` to zoom in on dense areas
4. Pass coordinates directly to click/move tools

Example workflow:
```
1. Call screenshot_grid() → see grid labels at 100px intervals
2. Notice target near grid (800, 400)
3. Call screenshot_region(750, 350, 200, 200, scale=3) → zoom in
4. Click at the exact coordinates read from the grid
```
