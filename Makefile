SHELL := /bin/bash
COMMIT := $(shell git rev-parse --short HEAD)
ifeq ($(shell git status --porcelain 2>/dev/null),)
    COMMIT_TAG := $(COMMIT)
else
    COMMIT_TAG := testing
endif
.PHONY: build agents claude codex crush computeruse computeruse-claude computeruse-codex computeruse-crush build publish publish-agents publish-computeruse clean

build: agents computeruse

agents: agents-claude agents-codex agents-crush
agents-claude:
	docker build -f ./agents/Dockerfile --target=claude -t ghcr.io/rudd3r/r4ft:claude -t ghcr.io/rudd3r/r4ft:claude-$(COMMIT_TAG) ./agents/
agents-codex:
	docker build -f ./agents/Dockerfile --target=codex -t ghcr.io/rudd3r/r4ft:codex -t ghcr.io/rudd3r/r4ft:codex-$(COMMIT_TAG) ./agents/
agents-crush:
	docker build -f ./agents/Dockerfile --target=crush -t ghcr.io/rudd3r/r4ft:crush -t ghcr.io/rudd3r/r4ft:crush-$(COMMIT_TAG) ./agents/

computeruse: computeruse-claude computeruse-codex computeruse-crush
computeruse-claude:
	docker build -f ./computeruse/Dockerfile --target=claude -t ghcr.io/rudd3r/r4ft:computeruse-claude -t ghcr.io/rudd3r/r4ft:computeruse-claude-$(COMMIT_TAG) ./computeruse/
computeruse-codex:
	docker build -f ./computeruse/Dockerfile --target=codex -t ghcr.io/rudd3r/r4ft:computeruse-codex -t ghcr.io/rudd3r/r4ft:computeruse-codex-$(COMMIT_TAG) ./computeruse/
computeruse-crush:
	docker build -f ./computeruse/Dockerfile --target=crush -t ghcr.io/rudd3r/r4ft:computeruse-crush -t ghcr.io/rudd3r/r4ft:computeruse-crush-$(COMMIT_TAG) ./computeruse/

publish: build publish-agents publish-computeruse
publish-agents: publish-agents-claude publish-agents-codex publish-agents-crush
publish-agents-claude:
	docker push ghcr.io/rudd3r/r4ft:claude && docker push ghcr.io/rudd3r/r4ft:claude-$(COMMIT_TAG)
publish-agents-codex:
	docker push ghcr.io/rudd3r/r4ft:codex && docker push ghcr.io/rudd3r/r4ft:codex-$(COMMIT_TAG)
publish-agents-crush:
	docker push ghcr.io/rudd3r/r4ft:crush && docker push ghcr.io/rudd3r/r4ft:crush-$(COMMIT_TAG)
publish-computeruse: publish-computeruse-claude publish-computeruse-codex publish-computeruse-crush
publish-computeruse-claude:
	docker push ghcr.io/rudd3r/r4ft:computeruse-claude && docker push ghcr.io/rudd3r/r4ft:computeruse-claude-$(COMMIT_TAG)
publish-computeruse-codex:
	docker push ghcr.io/rudd3r/r4ft:computeruse-codex && docker push ghcr.io/rudd3r/r4ft:computeruse-codex-$(COMMIT_TAG)
publish-computeruse-crush:
	docker push ghcr.io/rudd3r/r4ft:computeruse-crush && docker push ghcr.io/rudd3r/r4ft:computeruse-crush-$(COMMIT_TAG)

clean:
	docker rmi $(shell docker images ghcr.io/rudd3r/r4ft --format 'ghcr.io/rudd3r/r4ft:{{.Tag}}')


