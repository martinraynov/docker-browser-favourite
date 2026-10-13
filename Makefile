M = $(shell printf "\033[34;1m▶\033[0m")

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################
### MAIN FUNCTIONS ###
######################
SERVICE=browser

.PHONY: start
start: ## Start the SERVICE docker container (rebuilds and recreates)
	$(info $(M) Rebuilding Docker image and starting container...)
	@docker-compose -f ./docker/docker-compose.yml up -d --build --force-recreate
	$(info $(M) Service accessible via Traefik at: https://${SERVICE}.local.io/)

.PHONY: stop
stop: ## Stopping running SERVICE instances
	$(info $(M) Stopping ${SERVICE} instance)
	@docker-compose -f ./docker/docker-compose.yml down

.PHONY: logs
logs: ## Show logs from the SERVICE container
	@docker-compose -f ./docker/docker-compose.yml logs -f

.PHONY: add_localhost
add_localhost: ## Add local host into /etc/hosts file (need root permission)
	@ echo "# >>> ${SERVICE} for workspace" >> /etc/hosts
	@ echo "127.0.0.1\t${SERVICE}.local.io" >> /etc/hosts
	@ echo "# <<< ${SERVICE} for workspace" >> /etc/hosts
	$(info $(M) Local host added for ${SERVICE} application in your hosts file)

.PHONY: remove_localhost
remove_localhost: ## Remove local host from /etc/hosts file (need root permission)
	@ sed -e '$(shell grep --line-number "# >>> ${SERVICE} for workspace" /etc/hosts | cut -d ':' -f 1),$(shell grep --line-number "# <<< ${SERVICE} for workspace" /etc/hosts | cut -d ':' -f 1)d' /etc/hosts  > /etc/hosts.tmp
	@ cp /etc/hosts.tmp /etc/hosts && rm -f /etc/hosts.tmp
	$(info $(M) Local host removed for ${SERVICE} application in your hosts file)
