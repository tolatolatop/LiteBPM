SHELL := /bin/bash
VERSION := 0.0.1
# If you need to put your Makefile in a different directory to your compose
# file, you will need to edit the variable below
DOCKER := docker
SERVICE_NAME := litebpm
include .env

.PHONY: $(SERVICE_NAME)

help: ## This info
	@echo '_________________'
	@echo '| Make targets: |'
	@echo '-----------------'
	@cat Makefile | grep -E '^[a-zA-Z\/_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

all: up ## Brings up all services, see docker-compose.yml

up:  ## Start service
	make $(SERVICE_NAME)/up

build: ## Build image
	$(DOCKER) build . -t $(SERVICE_NAME):$(VERSION)

logs: ## Follow all container logs in terminal
	$(DOCKER) logs $(SERVICE_NAME)

clean: ## Clean container
	$(DOCKER) rm $(SERVICE_NAME)

clean_image: ## Clean image
	$(DOCKER) rmi $(SERVICE_NAME):$(VERSION)

stop: ## stop service
	$(DOCKER) stop $(SERVICE_NAME)

reboot: ## Reboot All Services
	make stop $(SERVICE_NAME)/up

state: ## show service state
	$(DOCKER) ps -a | grep $(SERVICE_NAME)

$(SERVICE_NAME):
	make $(SERVICE_NAME)/up

$(SERVICE_NAME)/up:
	$(DOCKER) run -itd --name $(SERVICE_NAME) -p $(PORT):8000 $(SERVICE_NAME):$(VERSION)
