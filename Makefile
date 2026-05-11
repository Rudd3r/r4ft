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

agents: claude codex crush pi openhands

claude:
	TYPE=claude BASE_PATH=agents $(MAKE) _build

pi:
	TYPE=pi BASE_PATH=agents $(MAKE) _build

openhands:
	TYPE=openhands BASE_PATH=agents $(MAKE) _build

codex:
	TYPE=codex BASE_PATH=agents $(MAKE) _build

crush:
	TYPE=crush BASE_PATH=agents $(MAKE) _build

computeruse: computeruse-claude computeruse-openhands computeruse-pi computeruse-codex computeruse-crush

computeruse-claude:
	TYPE=computeruse-claude BASE_PATH=computeruse $(MAKE) _build
	TYPE=computeruse-claude-openvscode BASE_PATH=computeruse $(MAKE) _build

computeruse-pi:
	TYPE=computeruse-pi BASE_PATH=computeruse $(MAKE) _build
	TYPE=computeruse-pi-openvscode BASE_PATH=computeruse $(MAKE) _build

computeruse-openhands:
	TYPE=computeruse-openhands BASE_PATH=computeruse $(MAKE) _build
	TYPE=computeruse-openhands-openvscode BASE_PATH=computeruse $(MAKE) _build

computeruse-codex:
	TYPE=computeruse-codex BASE_PATH=computeruse $(MAKE) _build
	TYPE=computeruse-codex-openvscode BASE_PATH=computeruse $(MAKE) _build

computeruse-crush:
	TYPE=computeruse-crush BASE_PATH=computeruse $(MAKE) _build
	TYPE=computeruse-crush-openvscode BASE_PATH=computeruse $(MAKE) _build

_build:
	docker build -f ./$(BASE_PATH)/Dockerfile --target=$(TYPE) $(BASE_TAGS) ./$(BASE_PATH)/

publish: publish-agents publish-computeruse

publish-agents: publish-claude publish-openhands publish-pi publish-codex publish-crush

publish-claude:
	TYPE=claude $(MAKE) _publish

publish-pi:
	TYPE=pi $(MAKE) _publish

publish-openhands:
	TYPE=openhands $(MAKE) _publish

publish-codex:
	TYPE=codex $(MAKE) _publish

publish-crush:
	TYPE=crush $(MAKE) _publish

publish-computeruse: publish-computeruse-claude publish-openhands-claude publish-pi-claude publish-computeruse-codex publish-computeruse-crush

publish-computeruse-claude:
	TYPE=computeruse-claude $(MAKE) _publish
	TYPE=computeruse-claude-openvscode $(MAKE) _publish

publish-pi-claude:
	TYPE=computeruse-pi $(MAKE) _publish
	TYPE=computeruse-pi-openvscode $(MAKE) _publish

publish-openhands-claude:
	TYPE=computeruse-openhands $(MAKE) _publish
	TYPE=computeruse-openhands-openvscode $(MAKE) _publish

publish-computeruse-codex:
	TYPE=computeruse-codex $(MAKE) _publish
	TYPE=computeruse-codex-openvscode $(MAKE) _publish

publish-computeruse-crush:
	TYPE=computeruse-crush $(MAKE) _publish
	TYPE=computeruse-crush-openvscode $(MAKE) _publish

_publish:
	for tag in $(TAGS); do docker push $$tag; done

list:
	docker images ghcr.io/rudd3r/r4ft --format 'ghcr.io/rudd3r/r4ft:{{.Tag}}'

clean:
	docker rmi $(shell docker images ghcr.io/rudd3r/r4ft --format 'ghcr.io/rudd3r/r4ft:{{.Tag}}')
	docker builder prune --filter "label=com.r4ft.project=r4ft" --force
