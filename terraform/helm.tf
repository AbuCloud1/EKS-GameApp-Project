# Commented out until EKS cluster is created and accessible
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.1"
  namespace  = "ingress-nginx"
  create_namespace = true

  values = [
    file("${path.module}/helm-values/nginx-ingress.yaml")
  ]

  depends_on = [aws_eks_cluster.main]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.13.3"
  namespace  = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  depends_on = [aws_eks_cluster.main]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = "1.14.1"
  namespace  = "monitoring"
  create_namespace = false

  values = [
    file("${path.module}/helm-values/external-dns.yaml")
  ]

  depends_on = [aws_eks_cluster.main]
}




