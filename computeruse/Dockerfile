# https://github.com/linuxserver/docker-webtop
FROM ghcr.io/linuxserver/webtop:debian-xfce AS base

LABEL "com.r4ft.project"="r4ft"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        aptitude \
        golang \
        nodejs \
        qemu-system-x86 \
        qemu-system-aarch64 \
        qemu-guest-agent \
        vim \
        curl \
        ca-certificates \
        gnupg \
        wget \
        apt-transport-https \
        python3 \
        python3-pip \
        python3-tk \
        python3-dev \
        lsb-release \
        netcat-openbsd \
        git \
        dos2unix \
        x11-apps \
        dbus \
        dbus-x11 \
        feh \
        xdg-utils \
        xdotool \
        scrot \
        openjdk-25-jdk-headless \
        unzip \
        pluma \
        nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PUID=1000
ENV PGID=1000
ENV TITLE="Agent Computer Use"
ENV SELKIES_MANUAL_WIDTH=1920
ENV SELKIES_MANUAL_HEIGHT=1080
ENV SELKIES_UI_SIDEBAR_SHOW_STATS=false
ENV SELKIES_UI_SIDEBAR_SHOW_APPS=false
ENV SELKIES_UI_SIDEBAR_SHOW_GAMEPADS=false
ENV SELKIES_UI_SIDEBAR_SHOW_GAMING_MODE=false
ENV SELKIES_UI_SIDEBAR_SHOW_TRACKPAD=false
ENV SELKIES_AUDIO_ENABLED=false
ENV SELKIES_MICROPHONE_ENABLED=false
ENV SELKIES_GAMEPAD_ENABLED=false
ENV MAX_RESOLUTION=1920x108

ENV AGENT_BROWSER_HEADED=true
RUN npm install -g agent-browser && agent-browser install \
    && DEBIAN_FRONTEND=noninteractive npx playwright install-deps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir matplotlib numpy pandas seaborn plotly
RUN curl -LsSf https://astral.sh/uv/install.sh | /bin/sh \
    && mv /config/.local/bin/uv* /usr/local/bin/
COPY x11-computer-use-mcp /usr/local/bin/

FROM base AS computeruse-claude
RUN npm install -g @anthropic-ai/claude-code

FROM base AS computeruse-codex
RUN npm install -g @openai/codex

FROM base AS computeruse-crush
RUN go install github.com/charmbracelet/crush@latest
RUN mkdir -p /usr/local/bin \
    && mv /config/go/bin/crush /usr/local/bin \
    && rm -rf /config/go
