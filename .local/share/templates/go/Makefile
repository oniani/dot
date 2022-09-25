PROJECT := app
SOURCES := $(wildcard *.go cmd/*/*.go)
VERSION := $(shell git describe --tags --long --dirty --always 2> /dev/null)

$(info project name:       $(PROJECT))
$(info source files:       $(SOURCES))
$(info version (hash/tag): $(VERSION))
$(info )

.PHONY: all
all: fmt lint build
	touch go.sum
	go mod tidy
	@printf "\n** OUTPUT **\n\n"
	@./$(PROJECT)

.PHONY: init
init:
	go mod init github.com/oniani/$(PROJECT)
	go mod tidy

.PHONY: build
build: $(SOURCES)
	go build -ldflags "-X main.version=$(VERSION)" -o $(PROJECT) ./cmd/$(PROJECT)

.PHONY: clean
clean:
	rm -f $(PROJECT) go.mod go.sum

.PHONY: fmt
fmt:
	go fmt $(SOURCES)

.PHONY: lint
lint:
	staticcheck $(SOURCES)

.PHONY: committed
committed:
	@git diff --exit-code > /dev/null || (printf "** COMMIT YOUR CHANGES FIRST **\n"; exit 1)

docker: $(SOURCES) build/Dockerfile
	docker build -t $(PROJECT):latest . -f build/Dockerfile --build-arg VERSION=$(VERSION)

.PHONY: publish
publish: committed lint fmt
	make docker
	docker tag $(PROJECT):latest davidoniani/$(PROJECT):$(VERSION)
	docker push davidoniani/$(PROJECT):$(VERSION)
