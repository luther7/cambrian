# Cambrian

A Kubernetes cluster for experimentation.

# To do

- [X] Google Cloud account set up scripts.
- [X] Google Cloud.
- [X] Helm.
- [ ] Istio.
  - [ ] Helm Chart with answer from: https://stackoverflow.com/questions/55009028/configure-ssl-certificates-in-kubernetes-with-cert-manager-istio-ingress-and-let
- [ ] Example application.
- [ ] Prometheus and Grafana.
- [ ] Skaffold.
- [ ] Tekton.
- [ ] plop.js or Cookie Cutter for templating?
- [ ] CI (GitLab?) for Terraform.
- [ ] Elastic Stack.
- [ ] Azure.
- [ ] OPA.
- [ ] Vitess.

### Issues
- [ ] Bug in permission for setting NS records in root zone.

# Set Up

### Required
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
3.  Run `make template.admin`. This will copy `seed.env.example` and
    `seed.tfvars.example` to `seed.env` and `seed.tfvars` in the admin
    environment (`./environment/admin`).
4.  Fill out the `seed.env` file in the admin environment. `seed.tfvars` does
    not need to be completed yet. To get your Organization id and Billing
    Account id try `gcloud organizations list && gcloud alpha billing accounts
    list`
5.  Run `make bootstrap.google`. This will run `./scripts/bootstrap-google`. You
    will now have an admin Google Cloud project with a service account and bucket
    for Terraform. This script will also barf a couple of files into
    `./environment/admin` for use with Terraform.
6.  Register a domain.
7.  In the Google Cloud console, create a Cloud DNS zone in the admin account.
8.  Update your domain's nameservers in your registrar's web console.
9.  Fill out the `seed.tfvars` file in the admin environment.
10. You are now ready to begin provisioning with Terraform.

### Notes
- You may now also use the Terraform service account with the gcloud SDK by 
  `source environments/admin/credentials.env`

# Terraform

### Process
1. Run `make template.environment`. This will copy `environments/template`
   to `environments/$ENVIRONMENT`. By default, `ENVIRONMENT=development`.
   Export a different value if desired.
2. Fill out the `seed.tfvars` file in the new environment.
3. Run `make terraform.init workspace.new`. This will initialize Terraform
   and create a new Terraform workspace for the new environment.
4. Run `make plan` to plan the Terraform provisioning.
5. Run `make apply` to apply the Terraform provisioning.

### Notes
- Run `make credentials.google` to set up your kubectl config to control the
  cluster
