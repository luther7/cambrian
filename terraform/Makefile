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

.PHONY: plan
plan: workspace.select
	source ../environments/admin/credentials.env && \
	  terraform plan \
	    -var-file=../environments/admin/seed.tfvars \
	    -var-file=../environments/$(environment)/seed.tfvars

.PHONY: apply
apply: workspace.select
	source ../environments/admin/credentials.env && \
	  terraform apply \
	    -var-file=../environments/admin/seed.tfvars \
	    -var-file=../environments/$(environment)/seed.tfvars

