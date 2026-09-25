resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = var.cert_manager_chart_version
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true
  timeout          = 600

  values = [yamlencode({
    crds = {
      enabled = true
    }
  })]
}

resource "helm_release" "rancher" {
  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/latest"
  chart            = "rancher"
  version          = var.rancher_chart_version
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true
  timeout          = 600

  values = [yamlencode({
    hostname = var.rancher_hostname
    replicas = 1
    ingress = {
      tls = {
        source = "rancher"
      }
    }
  })]

  depends_on = [helm_release.cert_manager]
}
