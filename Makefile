# -*- mode: makefile -*-

#
#--------------------------------------------------------------------------
##@ Help
#--------------------------------------------------------------------------
#
.PHONY: help
help: ## Print this help with list of available commands/targets and their purpose
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

#
#--------------------------------------------------------------------------
##@ Firebase
#--------------------------------------------------------------------------
#
.PHONY: firebase-login
firebase-login: ## Login to firebase
	@firebase login

.PHONY: deploy-prod
deploy-prod: build ## Deploy the app to production
	@firebase deploy --only hosting:jc-tn-url-shortener

.PHONY: deploy-beta
deploy-beta: build ## Deploy the app to beta channel
	@firebase hosting:channel:deploy --only jc-tn-url-shortener beta

.PHONY: deploy
deploy: deploy-beta ## Deploy the app to beta channel
