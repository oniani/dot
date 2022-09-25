# Good resource for the project layout: https://github.com/golang-standards/project-layout
PROJECT := app
SOURCES := $(wildcard *.go cmd/*/*.go)

# NOTE: Gets at least a hash when there is no tag
VERSION=$(shell git describe --tags --long --dirty --always 2> /dev/null)

$(info project:            $(PROJECT))
$(info files:              $(SOURCES))
$(info version (hash/tag): $(VERSION))
$(info )

all: fmt lint build
	@echo "\n** OUTPUT **\n"
	@./$(PROJECT)

init:
	go mod init github.com/oniani/$(PROJECT) 2>/dev/null
	go mod tidy

build: $(SOURCES)
	go build -ldflags "-X main.version=$(VERSION)" -o $(PROJECT) ./cmd/$(PROJECT)

.PHONY: fmt
clean:
	rm $(PROJECT)

.PHONY: fmt
fmt:
	go fmt $(SOURCES)

.PHONY: lint
lint:
	go vet $(SOURCES)

.PHONY: committed
committed:
	@git diff --exit-code > /dev/null || (echo "** COMMIT YOUR CHANGES FIRST **"; exit 1)

docker: $(SOURCES) build/Dockerfile
	docker build -t $(PROJECT):latest . -f build/Dockerfile --build-arg VERSION=$(VERSION)

.PHONY: publish
publish: committed lint fmt
	make docker
	docker tag $(PROJECT):latest davidoniani/$(PROJECT):$(VERSION)
	docker push davidoniani/$(PROJECT):$(VERSION)
