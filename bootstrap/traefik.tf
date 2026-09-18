resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = "41.6.0"
  namespace        = "traefik"
  create_namespace = true
  wait             = true
  timeout          = 300

  values = [yamlencode({
    ingressClass = {
      enabled        = true
      isDefaultClass = false
      name           = "traefik"
    }
  })]
}
