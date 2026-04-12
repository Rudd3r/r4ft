SHELL := /bin/bash
COMMIT := $(shell git rev-parse --short HEAD)

.PHONY: build agents claude codex crush computeruse computeruse-claude computeruse-codex computeruse-crush build-all

# Build all images
build-all: build

# Default build - builds agents and computeruse
build: agents computeruse

# Agent builds
agents: agents-claude agents-codex agents-crush

agents-claude:
    docker build -f ./agents/Dockerfile --target=claude -t ghcr.io/rudd3r/r4ft:claude -t ghcr.io/rudd3r/r4ft:claude-$(COMMIT) ./agents/

agents-codex:
    docker build -f ./agents/Dockerfile --target=codex -t ghcr.io/rudd3r/r4ft:codex -t ghcr.io/rudd3r/r4ft:codex-$(COMMIT) ./agents/

agents-crush:
    docker build -f ./agents/Dockerfile --target=crush -t ghcr.io/rudd3r/r4ft:crush -t ghcr.io/rudd3r/r4ft:crush-$(COMMIT) ./agents/

# Computer use builds
computeruse: computeruse-claude computeruse-codex computeruse-crush

computeruse-claude:
    docker build -f ./computeruse/Dockerfile --target=claude -t ghcr.io/rudd3r/r4ft:computeruse-claude -t ghcr.io/rudd3r/r4ft:computeruse-claude-$(COMMIT) ./computeruse/

computeruse-codex:
    docker build -f ./computeruse/Dockerfile --target=codex -t ghcr.io/rudd3r/r4ft:computeruse-codex -t ghcr.io/rudd3r/r4ft:computeruse-codex-$(COMMIT) ./computeruse/

computeruse-crush:
    docker build -f ./computeruse/Dockerfile --target=crush -t ghcr.io/rudd3r/r4ft:computeruse-crush -t ghcr.io/rudd3r/r4ft:computeruse-crush-$(COMMIT) ./computeruse/