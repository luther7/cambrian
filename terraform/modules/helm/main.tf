#
# Helm.
#

provider "kubernetes" {
  host                   = "https://${var.kube_cluster_endpoint}"
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_cert)
}

resource "kubernetes_service_account" "tiller" {
  provider = kubernetes

  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  provider   = kubernetes

  role_ref {
    name      = "cluster-admin"
    kind      = "ClusterRole"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    name      = "tiller"
    namespace = "kube-system"
    kind      = "ServiceAccount"
    api_group = ""
  }

  metadata {
    name = "tiller-role-binding"
  }

  depends_on = [kubernetes_service_account.tiller]
}
