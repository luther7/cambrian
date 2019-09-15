#
# Cambrian Terraform Makefile
#

shell := /bin/bash
ENVIRONMENT ?= development

main: apply

.PHONY: workspace.new
workspace.new:
	source ../environments/admin/credentials.env && \
	  terraform workspace new $(ENVIRONMENT)

.PHONY: workspace.select
workspace.select:
	source ../environments/admin/credentials.env && \
	  terraform workspace select $(ENVIRONMENT)

.PHONY: init
init:
	source ../environments/admin/credentials.env && \
	  terraform init \
	    -backend-config=../environments/admin/backend.tfvars

.PHONY: exec
exec: workspace.select
	source ../environments/admin/credentials.env && \
	  terraform $(command) \
	    -var-file=../environments/admin/seed.tfvars \
	    -var-file=../environments/$(ENVIRONMENT)/seed.tfvars

.PHONY: plan
plan: command=plan
plan: exec

.PHONY: apply
apply: command=apply
apply: exec

.PHONY: destroy
destroy: command=destroy
destroy: exec
