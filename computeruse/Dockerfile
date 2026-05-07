# https://github.com/linuxserver/docker-webtop
FROM ghcr.io/linuxserver/webtop:debian-xfce AS base

LABEL "com.r4ft.project"="r4ft"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        aptitude \
        golang \
        nodejs \
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
RUN mkdir -p /etc/docker && echo '{"storage-driver":"vfs"}' > /etc/docker/daemon.json

FROM base AS base-openvscode

RUN apt-get update && apt-get install -y --no-install-recommends libatomic1 \
    && rm -rf /var/lib/apt/lists/*

ARG RELEASE_TAG="openvscode-server-v1.109.5"
ARG RELEASE_ORG="gitpod-io"
ARG OPENVSCODE_SERVER_ROOT="/usr/local/lib/openvscode-server"
ENV OPENVSCODE_SERVER_ROOT=${OPENVSCODE_SERVER_ROOT}
EXPOSE 3535
RUN mkdir -p ${OPENVSCODE_SERVER_ROOT} /usr/local/bin && \
    if [ -z "${RELEASE_TAG}" ]; then \
        echo "The RELEASE_TAG build arg must be set." >&2 && \
        exit 1; \
    fi && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
        arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
        arch="arm64"; \
    elif [ "${arch}" = "armv7l" ]; then \
        arch="armhf"; \
    fi && \
    wget https://github.com/${RELEASE_ORG}/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    mv -f ${RELEASE_TAG}-linux-${arch} ${OPENVSCODE_SERVER_ROOT} && \
    rm -f ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    echo "/bin/sh\nexec ${OPENVSCODE_SERVER_ROOT}/${RELEASE_TAG}-linux-${arch}/bin/openvscode-server --accept-server-license-terms --telemetry-level off --port 3535 --host 0.0.0.0 --without-connection-token \"${@}\"" > /usr/local/bin/openvscode-server && \
    chmod +x /usr/local/bin/openvscode-server

FROM base AS computeruse-claude
RUN npm install -g @anthropic-ai/claude-code

FROM base AS computeruse-codex
RUN npm install -g @openai/codex

FROM base AS computeruse-crush
RUN go install github.com/charmbracelet/crush@latest \
    && mkdir -p /usr/local/bin \
    && mv /config/go/bin/crush /usr/local/bin \
    && rm -rf /config/go /config/.cache/

FROM base-openvscode AS computeruse-claude-openvscode
RUN npm install -g @anthropic-ai/claude-code

FROM base-openvscode AS computeruse-codex-openvscode
RUN npm install -g @openai/codex

FROM base-openvscode AS computeruse-crush-openvscode
RUN go install github.com/charmbracelet/crush@latest \
    && mkdir -p /usr/local/bin \
    && mv /config/go/bin/crush /usr/local/bin \
    && rm -rf /config/go /config/.cache/
