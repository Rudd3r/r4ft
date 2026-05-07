FROM debian:trixie-20260406 AS base

LABEL "com.r4ft.project"="r4ft"

RUN  echo "deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware" > /etc/apt/sources.list \
    && echo "deb-src http://deb.debian.org/debian trixie main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb-src http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb-src http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/debian-security/ trixie-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb-src http://security.debian.org/debian-security/ trixie-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && rm -f /etc/apt/sources.list.d/debian.source \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        bash \
        curl \
        tzdata \
        xz-utils \
        catatonit \
        cron \
        curl \
        gnupg \
        jq \
        netcat-traditional \
        tzdata \
        apt-utils \
        locales \
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
        sudo \
        aptitude \
    && locale-gen en_US.UTF-8 \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /var/log/* \
        /usr/share/man

RUN useradd --uid 911 --user-group --home-dir /home/agent --create-home --shell /bin/bash agent \
    && usermod -G users agent

RUN curl -LsSf https://astral.sh/uv/install.sh | /bin/sh \
    && mv /root/.local/bin/uv* /usr/local/bin/

ENV LANGUAGE="en_US.UTF-8" \
  LANG="en_US.UTF-8" \
  TERM="xterm"

COPY entrypoint.sh /
COPY bashrc /home/agent/.bashrc
WORKDIR /home/agent
ENTRYPOINT ["/entrypoint.sh"]
CMD []

FROM base AS claude
RUN npm install -g @anthropic-ai/claude-code

FROM base AS codex
RUN npm install -g @openai/codex

FROM base AS crush
RUN mkdir -p /usr/loca/share/ \
    && curl -Ls https://github.com/charmbracelet/crush/releases/download/v0.60.0/crush_0.60.0_Linux_x86_64.tar.gz --output - \
    | tar -C /usr/local/share/ -xzvf - \
    && ln -s /usr/local/share/crush_0.60.0_Linux_x86_64/crush /usr/local/bin/crush
