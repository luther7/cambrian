#
# Istio.
#

provider "kubernetes" {
  host                   = "https://${var.kube_cluster_endpoint}"
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_cert)
}

provider "helm" {
  service_account = "tiller"
  install_tiller  = "true"

  kubernetes {
    host                   = "https://${var.kube_cluster_endpoint}"
    cluster_ca_certificate = base64decode(var.kube_cluster_ca_cert)
  }
}

resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

resource "random_string" "kiali_password" {
  length  = 24
  special = false
}

resource "kubernetes_secret" "kiali_login" {
  data = {
    username   = "admin"
    passphrase = random_string.kiali_password.result
  }

  metadata {
    name      = "kiali"
    namespace = "istio-system"
  }
}

data "helm_repository" "istio" {
  name = "istio"
  url  = "https://storage.googleapis.com/istio-release/releases/1.3.0/charts/"
}

resource "helm_release" "istio_init" {
  name       = "istio-init"
  chart      = "istio-init"
  namespace  = "istio-system"
  repository = "istio"
  version    = "1.3.0"

  set {
    name  = "certmanager.enabled"
    value = "true"
  }
}

resource "helm_release" "istio" {
  name       = "istio"
  chart      = "istio"
  namespace  = "istio-system"
  repository = "istio"
  version    = "1.3.0"


  values = [
    <<-EOT
    certmanager:
      enabled: true
      email: ${var.istio_certmanager_email}

    gateways:
      istio-ingressgateway:
        loadBalancerIP: ${var.istio_ingressgateway_loadbalancer_ip}
        sds.enabled: true

    global:
      k8sIngress:
        enabled: true
        enableHttps: true
        gatewayName: ingressgateway

    kiali:
      enabled: true
      ingress:
        enabled: true
        annotations:
          kubernetes.io/ingress.class: istio
        hosts:
          - ${var.istio_dns_domain}
    EOT
    ,
  ]

  depends_on = [helm_release.istio_init]
}

