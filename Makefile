MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: ## executes lint step
	@echo "target: lint" && ./test/test.sh

test: ## executes test step
	@echo "target: test" && ./test/test.sh

build: ## executes build step
	@echo "target: build" && ./test/test.sh

post-process: ## executes post-process step
	@echo "target: post-process" && ./test/test.sh

simplecov:
	@echo "execute simplecov"
