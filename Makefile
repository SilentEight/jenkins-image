ROOT := $(shell dirname -- "$(abspath "$(lastword "$(MAKEFILE_LIST)")")")

BASE_IMAGE = jenkins/jenkins
IMAGE_NAME ?= jenkins-image
DOCKER_REPO := ghcr.io/silenteight
JENKINS_VERSION ?= lts-slim
IMAGE_VERSION ?= latest

IMAGE = $(DOCKER_REPO)/$(IMAGE_NAME)

.DEFAULT_GOAL := help
help:  ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:  ## Build container image
	docker pull $(BASE_IMAGE):$(JENKINS_VERSION)
	docker build --build-arg jenkins_version=$(JENKINS_VERSION) -t $(IMAGE):$(IMAGE_VERSION) docker

.PHONY: push
push: build  ## Push container image to repository
	@echo "Push $(IMAGE) to $(DOCKER_REPO)"
	docker push $(IMAGE):$(IMAGE_VERSION)
