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

    labels = {
      "istio-injection"                       = "disabled"
      "certmanager.k8s.io/disable-validation" = "true"
    }
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
    namespace = kubernetes_namespace.istio_system.metadata.0.name
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
  repository = data.helm_repository.istio.metadata.0.name
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
  repository = data.helm_repository.istio.metadata.0.name
  version    = "1.3.0"


  values = [
    <<-EOT
    certmanager:
      enabled: true
      email: ${var.istio_certmanager_email}

    gateways:
      istio-ingressgateway:
        loadBalancerIP: ${var.istio_ingressgateway_loadbalancer_ip}
        sds.enabled: false

    kiali:
      enabled: true
    EOT
    ,
  ]

  depends_on = [helm_release.istio_init]
}

