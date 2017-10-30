CONTAINER_NAME=vuejsdemo_app
DOCKER = docker
DOCKER_COMPOSE = docker-compose
DOCKER_RUN = $(DOCKER) run -it --rm -v $(PWD)/app:/app

UNAME := $(shell uname)

#COLORS
GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
CYAN_BG := $(shell tput -Txterm setab 6)

RESET  := $(shell tput -Txterm sgr0)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (sort keys %help) { \
	print "${WHITE}$$_:${RESET}\n"; \
	for (@{$$help{$$_}}) { \
	$$sep = " " x (32 - length $$_->[0]); \
	print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	}; \
	print "\n"; }

ifeq (composer-update,$(firstword $(MAKECMDGOALS)))
    PACKAGES =
    ifdef packages
        PACKAGES := $(packages)k
    endif
endif

help: ##@other Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
.PHONY: help

init-app: ##@development init app
	$(DOCKER_COMPOSE) up -d
	$(DOCKER} run -ti --rm -v $(PWD)/app:/vuejs/src/app -w / vuejstest_app "vue init webpack app"
.PHONY: init-app

start: ##@development start servers
	$(DOCKER_RUN) -w /app ${CONTAINER_NAME} npm install
	$(DOCKER_COMPOSE) up -d
.PHONY: start

logs: ##@development show server logs
	$(DOCKER_COMPOSE) logs -f
.PHONY: logs

restart: ##@development restart servers
	$(MAKE) stop
	$(MAKE) start
.PHONY: restart

stop: ##@development stop servers
	$(DOCKER_COMPOSE) down --remove-orphans
.PHONY: stop

setup: ##@development Create dev enviroment
	$(DOCKER_COMPOSE) build
	$(DOCKER_RUN) -w / ${CONTAINER_NAME} vue init webpack app
	cp -Rf $(PWD)/server/dev-server.js $(PWD)/app/build/dev-server.js
	$(MAKE) start
.PHONY: setup

cli: ##@development get shell
	$(DOCKER_RUN) -w /app ${CONTAINER_NAME} /bin/bash
.PHONY: cli
