# Cambrian

A GKE cluster for experimentation.

# To do

- [X] Google Cloud account set up scripts
- [ ] Google Cloud
  - [ ] Bug in permission for setting NS records in root zone 
- [X] Helm
- [ ] Istio
- [ ] Example application
- [ ] Prometheus and Grafana
- [ ] Skaffold
- [ ] Tekton
- [ ] CI (GitLab?) for Terraform
- [ ] Elastic Stack
- [ ] Azure
- [ ] OPA
- [ ] Vitess

# Set Up

We need to set up:
- A Google organization.
- A domain name.
- An admin Google Cloud project.
- A Service Account in the admin project for Terraform.
- A Cloud Storage bucket in the admin project which contains the Terraform state.
- Files for running Terraform - a backend and some environment variables.
- A root Cloud DNS Zone in the admin project.

### Process
1.  Create a new Google Organization.
2.  Install and init the gcloud SDK as the owner of the new Google Organization.
3.  Run `make template-admin`. This will copy `seed.env.example` and
    `seed.tfvars.example` to `seed.env` and `seed.tfvars` in the admin
    environment (`./environment/admin`).
4.  Fill out the `seed.env` file in the admin environment. `seed.tfvars` does
    not need to be completed yet. To get your Organization id and Billing
    Account id try `gcloud organizations list && gcloud alpha billing accounts
    list`
5.  Run `make bootstrap-admin`. This will run `./scripts/bootstrap-gcp`. You will
    now have an admin Google Cloud project with a service account and bucket for 
    Terraform. This script will also barf a couple of files into
    `./environment/admin` for use with Terraform.
6.  Register a domain.
7.  In the Google Cloud console, create a Cloud DNS zone in the admin account.
8.  Update your domain's nameservers in your registrar's web console.
9.  Fill out the `seed.tfvars` file in the admin environment.
10. You are now ready to begin provisioning with Terraform.

# Terraform

TODO
