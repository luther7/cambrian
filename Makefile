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

environment ?= development

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
