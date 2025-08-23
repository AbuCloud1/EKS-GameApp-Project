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

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace  = "argocd"
  create_namespace = true

  set {
    name  = "server.replicaCount"
    value = "1"
  }

  set {
    name  = "repoServer.replicaCount"
    value = "1"
  }

  set {
    name  = "applicationSet.replicaCount"
    value = "1"
  }

  depends_on = [aws_eks_cluster.main]
}


