EKS Production-Grade Project

https://github.com/CoderCo-Learning/eks-assignment-v1


This project focuses on deploying a secure application on a Production-grade Kubernetes cluster using Amazon EKS. 

It includes end-to-end infrastructure provisioning using AWS, Kubernetes, Terraform, CI/CD pipelines, ArgoCD, Helm, ExternalDNS and CertManager.

Task/Assignment 📝
Create your own repository and complete the task there. You may create an app in your repo and copy over any provided files as needed or build everything from scratch—your choice.

The Goal:
You will deploy a cloud-native application on Amazon EKS using best practices for infrastructure provisioning, CI/CD automation, and security. You’ll also set up GitOps automation with ArgoCD and dynamic DNS updates.

When complete, the application should be accessible via HTTPS at:
https://eks.<your-domain> or https://eks.labs.<your-domain>

Deliverables:

Infrastructure as code using Terraform modules for EKS and related AWS services.

CI/CD pipelines automating security scans, Docker image builds, and application deployments to EKS.

Dynamic DNS and SSL/TLS certificate management for secure endpoints.

Monitoring of EKS and application health with dashboards using Prometheus and Grafana.

GitOps-driven automated deployments via ArgoCD.

Project Tasks 🔧
AWS Infrastructure Setup (Terraform)

Create an EKS cluster, VPC, IAM roles, and security groups using Terraform.

Use reusable Terraform modules for infrastructure components. Ensure proper state management is in place.

Configure networking with private subnets for the EKS cluster and public subnets for load balancing.

Define IAM roles for the Kubernetes worker nodes and ensure security groups limit access to only required resources.

NGINX Ingress Controller

Deploy and configure the NGINX Ingress Controller on the EKS cluster using Helm charts or Kubernetes manifests.

Configure the controller to route incoming traffic to the correct Kubernetes services.

Set up rules for HTTPS using TLS certificates managed by CertManager (see task below).

CertManager (SSL/TLS Management)

Install and configure CertManager on the cluster.

Set up Let’s Encrypt or a custom CA to generate SSL certificates automatically for the application.

Integrate the certificates with the NGINX Ingress Controller for secure HTTPS connections.

Dynamic DNS Updates (ExternalDNS)

Deploy ExternalDNS on the EKS cluster to automate DNS record management.

Configure ExternalDNS to dynamically update DNS records in Route 53 based on changes in Kubernetes ingress resources.

Ensure the DNS updates reflect the public endpoint of the application when services or ingresses change.

CI/CD Pipelines: Automate Everything 🚀

Pipeline 1: Terraform

Automate Terraform deployments for provisioning EKS and related AWS resources.

Integrate state management using a remote backend (e.g., S3 + DynamoDB).

Include error handling and proper validation of Terraform code before deployments.

Pipeline 2: Docker, Security, and Kubernetes

Scan the Terraform code using Checkov to catch misconfigurations and ensure compliance with security best practices.

Build and push the Docker image of your application to Amazon ECR using the pipeline.

Use Trivy to scan the Docker image for vulnerabilities.

Deploy the application to EKS using Kubernetes manifests or Helm charts.

GitOps with ArgoCD

Set up ArgoCD to automate the deployment of Kubernetes manifests from your Git repository to the EKS cluster.

Ensure the deployment is triggered automatically when changes are pushed to the repo.

Create a GitOps workflow where the cluster state is reconciled with the desired state defined in the Git repository.

Monitoring and Observability

Deploy Prometheus to collect metrics from the Kubernetes cluster, including pods, nodes, namespaces, and services.

Set up Grafana to visualize the metrics and create custom dashboards.

Include dashboards showing high CPU/memory usage, pod health, node statuses, and Ingress traffic.

Architecture Documentation

Create a clear, well-documented architecture diagram using Lucidchart, draw.io, or Mermaid.

The diagram should show:

AWS infrastructure (VPC, EKS, subnets, security groups, IAM roles)

Traffic flow through the NGINX Ingress Controller

Dynamic DNS setup using ExternalDNS

Certificate management with CertManager

ArgoCD GitOps flow

Monitoring components (Prometheus and Grafana)

Useful Links 🔗
Terraform Docs

EKS Documentation

ArgoCD Docs

Checkov Security Scanning


Name		
hamidhirsi
hamidhirsi
Update README.md
5c9b449
 · 
9 months ago
js
initial commit
9 months ago
meta
initial commit
9 months ago
style
initial commit
9 months ago
.gitignore
initial commit
9 months ago
.jshintrc
initial commit
9 months ago
CONTRIBUTING.md
initial commit
9 months ago
LICENSE.txt
initial commit
9 months ago
README.md
Update README.md
9 months ago
Rakefile
initial commit
9 months ago
favicon.ico
initial commit
9 months ago
index.html
initial commit
9 months ago
package-lock.json
initial commit
9 months ago
Repository files navigation
README
Contributing
MIT license
Run This App Locally
Ensure nodejs is installed first

node -v 
npm -v
python -m http.server 3000
http://localhost:3000/
Marking Criteria
Category	Points	Criteria
Board / Tickets	10	- Proper ticketing system in place (e.g., Jira / Trello etc.).
- Tasks broken down into logical, actionable steps.
- Progress tracked effectively.
Terraform for AWS Infra	15	- EKS Cluster and VPC configured using Terraform.
- Reusable modules for infrastructure components.
- IAM roles and security groups properly configured.
NGINX Ingress Controller	10	- NGINX Ingress Controller successfully deployed on Kubernetes.
- Configured for Kubernetes Ingress traffic routing.
Monitoring Setup	15	- Prometheus and Grafana set up for cluster monitoring.
- Basic dashboard configured (e.g., high CPU/memory, pods, nodes, namespaces etc.)
Pipeline 1: Terraform	10	- Pipeline automates Terraform deployments for EKS infra (including modules).
- Includes proper state management and error handling.
Pipeline 2: Security, Docker, Kubernetes	30	- Includes Trivy and Checkov scans.
- Docker image build and push to ECR.
- Application deployed to EKS using Kubernetes manifests (If no ArgoCD).
- Pipeline automates secure deployments, ensuring error handling and compliance.
Bonus Criteria
Category	Points	Criteria
ArgoCD Integration	15	- ArgoCD set up for automated deployment to EKS.
Architecture	10	- Clear and well-documented architecture design with diagrams (e.g., deployment flow, service communication).
Helm	10	- Helm charts used for application and infrastructure deployments.
CertManager	10	- CertManager configured for managing SSL/TLS certificates.
ExternalDNS	10	- ExternalDNS configured for dynamic DNS updates based on Kubernetes ingress resources.
Total Points: 150