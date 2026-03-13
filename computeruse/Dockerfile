# https://github.com/linuxserver/docker-webtop
FROM lscr.io/linuxserver/webtop:ubuntu-xfce

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
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
        software-properties-common \
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
        openjdk-17-jdk-headless \
        unzip \
        pluma \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV AGENT_BROWSER_HEADED=true
RUN npm install -g agent-browser && agent-browser install \
    && DEBIAN_FRONTEND=noninteractive npx playwright install-deps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir matplotlib numpy pandas seaborn plotly
RUN npm install -g @anthropic-ai/claude-code
RUN curl -LsSf https://astral.sh/uv/install.sh | /bin/sh \
    && mv /config/.local/bin/uv* /usr/local/bin/
RUN npm install -g @openai/codex
COPY x11-computer-use-mcp /usr/local/bin/