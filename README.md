# CI/CD: GitOps & Github Actions

## How is it made?

A jam-packed EKS cluster deployed on AWS using Terraform, with GitOps automation via ArgoCD, NGINX Ingress for traffic management, Cert-Manager for SSL, and ExternalDNS for dynamic DNS, monitoring via Prometheus & Grafana and a complete CI/CD pipeline with GitHub Actions.

![ScreenRecording2025-08-25at16 24 43-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/bb0751b0-e735-4201-8a4e-ee1c4930e9d7)


## Architecture

<img width="1347" height="1273" alt="eks-proj drawio" src="https://github.com/user-attachments/assets/18b1f794-d7a0-4439-a89d-c4211e3ff959" />

## Local Setup


### Prereqs

- **AWS CLI** - For AWS service interaction
- **kubectl** - Kubernetes command-line tool
- **Terraform** - Infrastructure as Code
- **Helm** - Kubernetes package manager
- **Docker** - Containerization

### Project Management

**Jira** to plan, track and manage the project

<img width="1443" height="580" alt="Screenshot 2025-08-25 at 00 28 15" src="https://github.com/user-attachments/assets/e9414adc-fbc3-4154-b87e-1592d5bc67de" />

## Infrastructure Overview

### Terraform

To ensure modularity and code reusability (DRY principle), I've structured Terraform using separate files for each infrastructure component:

#### **VPC Module**
- Used a custom VPC setup with public and private subnets
- NAT gateways for private internet access
- Internet gateway for public access

#### **EKS Module**
- Creates an Amazon EKS cluster with managed node groups
- Associated IAM roles based on the custom VPC setup

#### **IAM Module**
- Set up IAM roles and policies for the EKS cluster and node groups
- Includes Route53 permissions for ExternalDNS to manage DNS records

#### **Helm Module**
- Configures the NGINX Ingress Controller to route traffic to services
- Cert-Manager for automatic certificate management
- ExternalDNS to dynamically create DNS records

## Workflow

### **1. ECR Push Pipeline**
- Builds and pushes the Docker image to Amazon Elastic Container Registry (ECR)
- Security scanning using Trivy

### **2. Terraform & Kubernetes Deploy Pipeline**
- Automates AWS infra deployment using Terraform
- Runs Checkov security scanning
- Creates a Terraform plan and applies the changes
- Deploys necessary resources to the EKS cluster

## CI/CD: GitOps & GitHub Actions

<img width="1920" height="989" alt="Screenshot 2025-08-25 at 02 12 46" src="https://github.com/user-attachments/assets/87b26c4e-424c-4bef-b687-d39755e55329" />
<img width="456" height="414" alt="Screenshot 2025-08-25 at 02 18 38" src="https://github.com/user-attachments/assets/3197f7d5-f131-4d32-813d-41d3b4052734" />
<img width="456" height="329" alt="Screenshot 2025-08-25 at 02 17 51" src="https://github.com/user-attachments/assets/eff1ecbd-07f3-403e-9d31-e46b56b622ff" />

## Security & Observability

### Checkov & Trivy

<img width="474" height="399" alt="Screenshot 2025-08-25 at 02 24 47" src="https://github.com/user-attachments/assets/cb5a047c-d21b-4bf5-b9c5-e1b4c97001de" />
<img width="474" height="399" alt="Screenshot 2025-08-25 at 02 24 47" src="https://github.com/user-attachments/assets/12a3d228-ecd5-49b0-a84a-5ff12e0d69ca" />


### Grafana & Prometheus for Monitoring

<img width="1920" height="1074" alt="Screenshot 2025-08-24 at 22 13 13" src="https://github.com/user-attachments/assets/2a0c7654-8f2c-42c4-9d01-60a4548050a9" />

## Trade-offs and Design Decisions

- **EKS Managed Service**: Went with EKS managed service for better reliability and reduced operational overhead, even though it costs more than self-managed Kubernetes
- **Service Mesh**: Was thinking of adding Istio service mesh or mTLS but because of the complexity and time constraints, decided not to include it in this project

## Future Improvements

- Implement Istio Service Mesh or mTLS
- Implement blue-green deployments and add approval gates for production releases
- Integrate more comprehensive security scanning and compliance checks
- Create a more customised dashboard in Grafana
- Add alerting rules in Prometheus and integrate with Teams or Slack for notifications
