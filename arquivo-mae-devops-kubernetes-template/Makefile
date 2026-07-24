SHELL := /bin/sh

DEPLOY_ENV ?= development
BUILD ?=
TARGET ?= development

.PHONY: help base-check git-snapshot devops-preflight k8s-render k8s-validate k8s-diff k8s-deploy drone-builds drone-promote

help:
	@printf '%s\n' \
	  'Comandos do template:' \
	  '  make base-check                         valida a documentação base' \
	  '  make git-snapshot                       captura estado Git sem alterar' \
	  '  make devops-preflight                   verifica ferramentas e configuração' \
	  '  make k8s-render DEPLOY_ENV=development  renderiza manifests localmente' \
	  '  make k8s-validate DEPLOY_ENV=development valida manifests e, opcionalmente, o servidor' \
	  '  make k8s-diff DEPLOY_ENV=development    executa preflight, dry-run e diff, sem aplicar' \
	  '  make k8s-deploy DEPLOY_ENV=development  aplica somente com ALLOW_CLUSTER_WRITE=1' \
	  '  make drone-builds                       lista builds do DRONE_REPO' \
	  '  make drone-promote BUILD=42 TARGET=development promove com ALLOW_DRONE_WRITE=1'

base-check:
	python3 scripts/verificar_base.py

git-snapshot:
	sh scripts/devops/git_snapshot.sh

devops-preflight:
	sh scripts/devops/preflight.sh local

k8s-render:
	DEPLOY_ENV='$(DEPLOY_ENV)' sh scripts/devops/k8s_render.sh

k8s-validate:
	DEPLOY_ENV='$(DEPLOY_ENV)' sh scripts/devops/k8s_validate.sh

k8s-diff:
	DEPLOY_ENV='$(DEPLOY_ENV)' DRY_RUN_ONLY=1 sh scripts/devops/k8s_deploy.sh '$(DEPLOY_ENV)'

k8s-deploy:
	DEPLOY_ENV='$(DEPLOY_ENV)' sh scripts/devops/k8s_deploy.sh '$(DEPLOY_ENV)'

drone-builds:
	@test -n "$$DRONE_REPO" || (echo 'ERRO: DRONE_REPO não definido.' >&2; exit 1)
	drone build ls "$$DRONE_REPO" --limit 10

drone-promote:
	@test -n '$(BUILD)' || (echo 'ERRO: informe BUILD=<numero>.' >&2; exit 1)
	ALLOW_DRONE_WRITE="$$ALLOW_DRONE_WRITE" sh scripts/devops/drone_promote.sh '$(BUILD)' '$(TARGET)'
