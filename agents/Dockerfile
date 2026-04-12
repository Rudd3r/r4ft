FROM ghcr.io/linuxserver/baseimage-debian:trixie AS base

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
        openjdk-25-jdk-headless \
        unzip \
        npm \
        nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | /bin/sh \
    && mv /root/.local/bin/uv* /usr/local/bin/

FROM base AS claude
RUN npm install -g @anthropic-ai/claude-code

FROM base AS codex
RUN npm install -g @openai/codex

FROM base AS crush
RUN go install github.com/charmbracelet/crush@latest
RUN mkdir -p /usr/local/bin \
    && mv /root/go/bin/crush /usr/local/bin \
    && rm -rf /root/go
