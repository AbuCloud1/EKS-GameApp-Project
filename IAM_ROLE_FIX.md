# IAM Role Fix for EKS Access

## 🔧 **Issue Fixed:**

GitHub Actions role `github-actions-role` was missing EKS permissions, causing:
```
Error: User: arn:aws:sts::106801461504:assumed-role/github-actions-role/GitHubActions 
is not authorized to perform: eks:DescribeCluster on resource: arn:aws:eks:eu-west-1:106801461504:cluster/eks-cluster
```

## ✅ **Policies Added:**

1. **AmazonEKSClusterPolicy** - Basic EKS cluster access
2. **AmazonEKS_CNI_Policy** - Container networking permissions  
3. **AmazonEKSWorkerNodePolicy** - Worker node management

## 🚀 **Result:**

The role now has all necessary permissions for:
- ✅ ECR image push/pull
- ✅ EKS cluster access (`eks update-kubeconfig`)
- ✅ Kubernetes deployments
- ✅ Security scanning (Checkov, Trivy)

## 📋 **Current Role Permissions:**

- AmazonEC2ContainerRegistryPowerUser
- AmazonEKSClusterPolicy  
- AmazonEKS_CNI_Policy
- AmazonEKSWorkerNodePolicy

The EKS job should now work correctly! 🎉
