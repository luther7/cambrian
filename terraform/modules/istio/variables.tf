#
# Variables.
#

variable "kube_cluster_endpoint" {
  description = "Cluster endpoint"
}

variable "kube_cluster_ca_cert" {
  description = "Cluster CA cert"
}

variable "istio_certmanager_email" {
  description = "Istio cert manager email"
}

variable "istio_dns_domain" {
  description = "Istio DNS domain"
}

variable "istio_ingressgateway_loadbalancer_ip" {
  description = "Istio ingress gateway loadbalancer IP"
}
