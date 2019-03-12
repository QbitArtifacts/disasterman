DOCKER_REGISTRY := registry-1.docker.io
DOCKER_IMAGE := disasterman-server
DOCKER_TAG := master
BUILD_DIR := server

all: login build push deploy

login:
	docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD) $(DOCKER_REGISTRY)

build:
	cd $(BUILD_DIR) && docker build . -t $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):$(DOCKER_TAG)

push:
	docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):$(DOCKER_TAG)

deploy:
	WEBHOOK=$(DEPLOY_WEBHOOK) ./deploy.sh
