#
# Cambrian Terraform Makefile
#

shell := /bin/bash
environment ?= development

.PHONY: workspace.new
workspace.new:
	source ../environments/admin/credentials.env && \
	  terraform workspace new $(environment)

.PHONY: workspace.select
workspace.select:
	source ../environments/admin/credentials.env && \
	  terraform workspace select $(environment)

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
	    -var-file=../environments/$(environment)/seed.tfvars

.PHONY: plan
plan: command=plan
plan: exec

.PHONY: apply
apply: command=apply
apply: exec

.PHONY: destroy
destroy: command=destroy
destroy: exec
