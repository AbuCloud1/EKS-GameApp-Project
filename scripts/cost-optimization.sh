#!/bin/bash

# Cost Optimization Script for EKS Project
# This script helps reduce costs when not actively working on the project

echo "🔧 EKS Project Cost Optimization Script"
echo "======================================"

case "$1" in
  "scale-down")
    echo "📉 Scaling down resources to save costs..."
    
    # Scale down EKS node group to minimum
    echo "Scaling EKS nodes to minimum..."
    aws eks update-nodegroup-config \
      --cluster-name eks-cluster \
      --nodegroup-name eks-nodes \
      --scaling-config minSize=1,maxSize=1,desiredSize=1 \
      --region eu-west-1
    
    # Scale down ArgoCD
    echo "Scaling down ArgoCD..."
    kubectl scale deployment --replicas=0 -n argocd argocd-server 2>/dev/null || echo "ArgoCD not running"
    
    # Scale down monitoring
    echo "Scaling down monitoring..."
    kubectl scale deployment --replicas=0 -n monitoring prometheus 2>/dev/null || echo "Prometheus not running"
    kubectl scale deployment --replicas=0 -n monitoring grafana 2>/dev/null || echo "Grafana not running"
    
    # Scale down 2048 game
    echo "Scaling down 2048 game..."
    kubectl scale deployment --replicas=0 -n 2048-game game-2048 2>/dev/null || echo "2048 game not running"
    
    echo "✅ Resources scaled down. Estimated cost savings: 60-80%"
    ;;
    
  "scale-up")
    echo "📈 Scaling up resources for development..."
    
    # Scale up EKS node group
    echo "Scaling EKS nodes to normal..."
    aws eks update-nodegroup-config \
      --cluster-name eks-cluster \
      --nodegroup-name eks-nodes \
      --scaling-config minSize=2,maxSize=3,desiredSize=2 \
      --region eu-west-1
    
    # Scale up ArgoCD
    echo "Scaling up ArgoCD..."
    kubectl scale deployment --replicas=1 -n argocd argocd-server 2>/dev/null || echo "ArgoCD not running"
    
    # Scale up monitoring
    echo "Scaling up monitoring..."
    kubectl scale deployment --replicas=1 -n monitoring prometheus 2>/dev/null || echo "Prometheus not running"
    kubectl scale deployment --replicas=1 -n monitoring grafana 2>/dev/null || echo "Grafana not running"
    
    # Scale up 2048 game
    echo "Scaling up 2048 game..."
    kubectl scale deployment --replicas=1 -n 2048-game game-2048 2>/dev/null || echo "2048 game not running"
    
    echo "✅ Resources scaled up for development"
    ;;
    
  "stop-cluster")
    echo "🛑 Stopping EKS cluster (maximum cost savings)..."
    echo "⚠️  WARNING: This will stop all services and may take time to restart"
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Stop EKS cluster
      aws eks update-cluster-config \
        --cluster-name eks-cluster \
        --region eu-west-1 \
        --resources-vpc-config endpointPrivateAccess=false,endpointPublicAccess=false
      
      echo "✅ EKS cluster stopped. Estimated cost savings: 90-95%"
      echo "💡 Use './scripts/cost-optimization.sh scale-up' to restart"
    else
      echo "❌ Operation cancelled"
    fi
    ;;
    
  "start-cluster")
    echo "🚀 Starting EKS cluster..."
    
    # Start EKS cluster
    aws eks update-cluster-config \
      --cluster-name eks-cluster \
      --region eu-west-1 \
      --resources-vpc-config endpointPrivateAccess=true,endpointPublicAccess=true
    
    echo "✅ EKS cluster starting. Wait 5-10 minutes, then run 'scale-up'"
    ;;
    
  "status")
    echo "📊 Current resource status:"
    
    # Check EKS cluster status
    echo "EKS Cluster:"
    aws eks describe-cluster --cluster-name eks-cluster --region eu-west-1 --query 'cluster.status' --output text 2>/dev/null || echo "Not found"
    
    # Check node group status
    echo "Node Group:"
    aws eks describe-nodegroup --cluster-name eks-cluster --nodegroup-name eks-nodes --region eu-west-1 --query 'nodegroup.status' --output text 2>/dev/null || echo "Not found"
    
    # Check deployments
    echo "Deployments:"
    kubectl get deployments --all-namespaces 2>/dev/null || echo "Cannot connect to cluster"
    ;;
    
  *)
    echo "Usage: $0 {scale-down|scale-up|stop-cluster|start-cluster|status}"
    echo ""
    echo "Commands:"
    echo "  scale-down     - Scale resources to minimum (save 60-80% costs)"
    echo "  scale-up       - Scale resources to normal for development"
    echo "  stop-cluster   - Stop EKS cluster (save 90-95% costs)"
    echo "  start-cluster  - Start EKS cluster"
    echo "  status         - Show current resource status"
    echo ""
    echo "💡 Tip: Use 'scale-down' when not working, 'scale-up' when developing"
    exit 1
    ;;
esac
