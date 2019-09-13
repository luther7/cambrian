#
# Cambrian Terraform Makefile
#

environment ?= development

.PHONY: workspace.new
workspace.new:
	terraform workspace new $(environment)

.PHONY: workspace.select
workspace.select:
	terraform workspace select $(environment)

.PHONY: init
init:
	terraform init \
	  -backend-config=../environments/admin/backend.tfvars

.PHONY: plan
plan: workspace.select
	terraform plan \
	  -var-file=../environments/admin/seed.tfvars \
	  -var-file=../environments/$(environment)/seed.tfvars

.PHONY: apply
apply: workspace.select
	terraform apply \
	  -var-file=../environments/admin/seed.tfvars \
	  -var-file=../environments/$(environment)/seed.tfvars

