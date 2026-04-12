FROM ghcr.io/linuxserver/baseimage-debian:trixie AS base

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
        unzip \
        npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | /bin/sh \
    && mv /root/.local/bin/uv* /usr/local/bin/

CMD ["/bin/bash"]

FROM base AS claude
RUN npm install -g @anthropic-ai/claude-code

FROM base AS codex
RUN npm install -g @openai/codex

FROM base AS crush
RUN go install github.com/charmbracelet/crush@latest \
    && mkdir -p /usr/local/bin \
    && mv /root/go/bin/crush /usr/local/bin \
    && rm -rf /root/go /root/.cache/
