#
# Cambrian Makefile
#

shell := /bin/bash

.PHONY: template.admin
template.admin:
	. ./scripts/template-admin

.PHONY: bootstrap.google
bootstrap.google:
	. ./scripts/bootstrap-google

ENVIRONMENT ?= development

.PHONY: template.environment
template.environment:
	ENVIRONMENT=$(ENVIRONMENT) ./scripts/template-environment

.PHONY: credentials.google
credentials.google:
	ENVIRONMENT=$(ENVIRONMENT) ./scripts/credentials-google

.PHONY: workspace.new
workspace.new:
	$(MAKE) -C terraform workspace.new

.PHONY: workspace.select
workspace.select:
	$(MAKE) -C terraform workspace.select

.PHONY: init
init:
	$(MAKE) -C terraform init

.PHONY: plan
plan:
	$(MAKE) -C terraform plan

.PHONY: apply
apply:
	$(MAKE) -C terraform apply

.PHONY: destroy
destroy:
	$(MAKE) -C terraform destroy
