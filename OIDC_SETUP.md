# OIDC Setup Guide for GitHub Actions

## 🔐 **What is OIDC?**

**OIDC (OpenID Connect)** allows GitHub Actions to authenticate with AWS without storing long-term credentials. It's more secure and follows AWS best practices.

## 🚀 **Benefits of OIDC:**

- ✅ **No long-term credentials** stored in GitHub
- ✅ **Automatic credential rotation**
- ✅ **Fine-grained permissions** control
- ✅ **More secure** than access keys
- ✅ **AWS recommended** approach

---

## 🏗️ **Setup Steps:**

### **Step 1: Create OIDC Identity Provider in AWS**

Run this AWS CLI command:

```bash
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1
```

### **Step 2: Create IAM Role for GitHub Actions**

Create a file called `github-actions-role.json`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::YOUR_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:*"
        }
      }
    }
  ]
}
```

### **Step 3: Create the IAM Role**

```bash
aws iam create-role \
  --role-name github-actions-role \
  --assume-role-policy-document file://github-actions-role.json
```

### **Step 4: Attach Required Policies**

```bash
# ECR permissions
aws iam attach-role-policy \
  --role-name github-actions-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser

# EKS permissions
aws iam attach-role-policy \
  --role-name github-actions-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy

# Additional permissions for EKS operations
aws iam attach-role-policy \
  --role-name github-actions-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
```

---

## 🔧 **Update Your Workflow:**

### **Current Configuration:**
```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::106801461504:role/github-actions-role
    aws-region: ${{ env.AWS_REGION }}
```

### **Replace Placeholders:**
- `YOUR_ACCOUNT_ID` → 106801461504 (your actual AWS account ID)
- `YOUR_GITHUB_USERNAME` → Your GitHub username
- `YOUR_REPO_NAME` → Your repository name

---

## 📋 **Required Permissions:**

### **ECR Access:**
- Push/pull images
- Create repositories
- Manage image tags

### **EKS Access:**
- Update kubeconfig
- Deploy applications
- Manage cluster resources

### **S3 Access (if using remote state):**
- Read/write Terraform state
- Access to state bucket

---

## 🚨 **Important Notes:**

### **Account ID:**
- Find your AWS account ID in the AWS Console
- Or run: `aws sts get-caller-identity --query Account --output text`

### **Repository Name:**
- Must match exactly: `AbuCloud1/EKS-GameApp-Project`
- Case sensitive

### **Branch Protection:**
- OIDC works with branch protection rules
- Can restrict which branches can assume the role

---

## ✅ **Verification Steps:**

### **1. Test IAM Role:**
```bash
aws sts assume-role \
  --role-arn arn:aws:iam::YOUR_ACCOUNT_ID:role/github-actions-role \
  --role-session-name test-session
```

### **2. Check Permissions:**
```bash
aws iam list-attached-role-policies \
  --role-name github-actions-role
```

### **3. Test ECR Access:**
```bash
aws ecr describe-repositories --region eu-west-1
```

---

## 🔍 **Troubleshooting:**

### **Common Issues:**
1. **Wrong account ID** → Check AWS Console
2. **Repository name mismatch** → Verify exact name
3. **Missing policies** → Attach required policies
4. **OIDC provider not created** → Run setup commands

### **Debug Commands:**
```bash
# Check OIDC provider
aws iam list-open-id-connect-providers

# Check role details
aws iam get-role --role-name github-actions-role

# Check role policies
aws iam list-attached-role-policies --role-name github-actions-role
```

---

## 🎯 **Next Steps:**

1. **Get your AWS account ID**
2. **Create OIDC provider**
3. **Create IAM role**
4. **Attach policies**
5. **Update workflow with correct ARN**
6. **Test the pipeline**

This approach is much more secure and follows AWS security best practices! 🎉
