# EKS Production-Grade Project

## 🎯 Project Overview
This project demonstrates deploying a secure application on Amazon EKS using best practices for infrastructure provisioning, CI/CD automation, and security. We'll implement GitOps automation with ArgoCD and dynamic DNS updates.

## 🌍 Region
**Europe (Ireland) - eu-west-1**

## 📁 Project Structure
```
eks-project/
├── .github/workflows/     # CI/CD pipelines
├── app/                   # Application code
├── argocd/               # ArgoCD configurations
├── cert-man/             # Certificate management
├── manifests/            # Kubernetes manifests
├── scripts/              # Deployment scripts
├── terraform/            # Infrastructure as Code
│   └── helm-values/      # Helm chart configurations
└── README.md             # This file
```

## 🚀 Key Components

### Infrastructure (Terraform)
- **VPC & Networking**: Private/public subnets, NAT gateways
- **EKS Cluster**: Kubernetes cluster with node groups
- **IAM & Security**: Roles, policies, and security groups
- **IRSA**: IAM Roles for Service Accounts (secure pod-to-AWS communication)

### Application Layer
- **NGINX Ingress Controller**: Traffic routing and load balancing
- **CertManager**: Automatic SSL/TLS certificate management
- **ExternalDNS**: Dynamic DNS updates for Route53

### GitOps & CI/CD
- **ArgoCD**: Automated deployment from Git repository
- **GitHub Actions**: Infrastructure and application pipelines
- **Security Scanning**: Checkov (Terraform) and Trivy (Docker)

### Monitoring
- **Prometheus**: Metrics collection
- **Grafana**: Visualization and dashboards

## 🏗️ Architecture
```
Internet → Route53 → ALB → NGINX Ingress → EKS Pods
                ↓
            ExternalDNS ← CertManager ← Let's Encrypt
```

## 📋 Prerequisites
- AWS CLI configured
- Terraform installed
- kubectl installed
- Helm installed
- Domain name with Route53 hosted zone

## 🚀 Quick Start
1. Configure AWS credentials
2. Update domain variables in `terraform/locals.tf`
3. Run `terraform init` and `terraform plan`
4. Deploy infrastructure with `terraform apply`
5. Deploy applications via ArgoCD

## 🔒 Security Features
- Private subnets for EKS nodes
- IAM roles with least privilege
- Network policies and security groups
- Automatic SSL certificate rotation
- Security scanning in CI/CD pipeline

## 📊 Monitoring & Observability
- Real-time cluster metrics
- Application performance monitoring
- Alerting for critical issues
- Custom Grafana dashboards

