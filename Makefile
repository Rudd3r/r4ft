SHELL := /bin/bash
COMMIT := $(shell git rev-parse --short HEAD)

ifeq ($(shell git status --porcelain 2>/dev/null),)
    BASE_TAGS := -t ghcr.io/rudd3r/r4ft:$(TYPE) -t ghcr.io/rudd3r/r4ft:$(TYPE)-$(COMMIT)
    TAGS := ghcr.io/rudd3r/r4ft:$(TYPE) ghcr.io/rudd3r/r4ft:$(TYPE)-$(COMMIT)
else
    BASE_TAGS := -t ghcr.io/rudd3r/r4ft:$(TYPE)-testing
    TAGS := ghcr.io/rudd3r/r4ft:$(TYPE)-testing
endif

.PHONY: build _build agents claude codex crush computeruse computeruse-claude computeruse-codex computeruse-crush build publish publish-agents publish-computeruse publish-computeruse-crush publish-computeruse-codex publish-computeruse-claude publish-codex publish-claude publish-codex clean

build: agents computeruse

agents: claude codex crush

claude:
	TYPE=claude BASE_PATH=agents $(MAKE) _build

codex:
	TYPE=codex BASE_PATH=agents $(MAKE) _build

crush:
	TYPE=crush BASE_PATH=agents $(MAKE) _build

computeruse: computeruse-claude computeruse-codex computeruse-crush

computeruse-claude:
	TYPE=computeruse-claude BASE_PATH=computeruse $(MAKE) _build

computeruse-codex:
	TYPE=computeruse-codex BASE_PATH=computeruse $(MAKE) _build

computeruse-crush:
	TYPE=computeruse-crush BASE_PATH=computeruse $(MAKE) _build

_build:
	docker build -f ./$(BASE_PATH)/Dockerfile --target=$(TYPE) $(BASE_TAGS) ./$(BASE_PATH)/

publish: publish-agents publish-computeruse

publish-agents: publish-claude publish-codex publish-crush

publish-claude:
	TYPE=claude $(MAKE) _publish

publish-codex:
	TYPE=codex $(MAKE) _publish

publish-crush:
	TYPE=crush $(MAKE) _publish

publish-computeruse: publish-computeruse-claude publish-computeruse-codex publish-computeruse-crush

publish-computeruse-claude:
	TYPE=computeruse-claude $(MAKE) _publish

publish-computeruse-codex:
	TYPE=computeruse-codex $(MAKE) _publish

publish-computeruse-crush:
	TYPE=computeruse-crush $(MAKE) _publish

_publish:
	docker push $(TAGS)

list:
	docker images ghcr.io/rudd3r/r4ft --format 'ghcr.io/rudd3r/r4ft:{{.Tag}}'

clean:
	docker rmi $(shell docker images ghcr.io/rudd3r/r4ft --format 'ghcr.io/rudd3r/r4ft:{{.Tag}}')
	docker builder prune --filter "label=com.r4ft.project=r4ft" --force
