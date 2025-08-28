# Breakout Trade DevOps – Step by Step Setup Guide

This document provides a detailed step-by-step process with commands to deploy the Breakout Trade app using Kubernetes, Helm, Jenkins, Argo CD, Git, and Maven.

---

## 1. Prerequisites
- Install Docker
- Install Minikube or access a Kubernetes cluster
- Install Helm
- Install Argo CD
- Install Jenkins (or run Jenkins in Docker/K8s)
- Install Git
- Install Maven
- Node.js & npm

---

## 2. Clone the Repo
```bash
git clone https://github.com/your-username/breakout-trade-devops.git
cd breakout-trade-devops
```

---

## 3. Build Backend with Maven
```bash
cd backend
mvn clean package
cd ..
```

---

## 4. Build Docker Images
```bash
docker build -t breakout-trade-frontend:latest frontend/
docker build -t breakout-trade-backend:latest backend/
```

Tag and push to DockerHub (or your registry):
```bash
docker tag breakout-trade-frontend:latest <your-dockerhub-username>/breakout-trade-frontend:latest
docker push <your-dockerhub-username>/breakout-trade-frontend:latest

docker tag breakout-trade-backend:latest <your-dockerhub-username>/breakout-trade-backend:latest
docker push <your-dockerhub-username>/breakout-trade-backend:latest
```

---

## 5. Deploy with Helm
```bash
helm upgrade --install breakout-trade k8s/helm/breakout-trade/
```

Check resources:
```bash
kubectl get pods
kubectl get svc
```

---

## 6. Argo CD Setup
Port-forward Argo CD UI:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Login:
```bash
argocd login localhost:8080
```
Create app:
```bash
argocd app create breakout-trade   --repo https://github.com/your-username/breakout-trade-devops.git   --path k8s/helm/breakout-trade   --dest-server https://kubernetes.default.svc   --dest-namespace default
```
Sync app:
```bash
argocd app sync breakout-trade
```

---

## 7. Jenkins Setup
- Create Jenkins pipeline job using `jenkins/Jenkinsfile`
- Add Docker, Maven, and Kube config credentials

Trigger build:
```bash
mvn clean package -f backend/pom.xml
docker build -t breakout-trade-frontend:latest frontend/
docker build -t breakout-trade-backend:latest backend/
helm upgrade --install breakout-trade k8s/helm/breakout-trade/
```

---

## 8. Access the App
```bash
minikube service breakout-trade
```

If ingress is configured:
```bash
kubectl get ingress
```

---

## 9. Cleanup
```bash
helm uninstall breakout-trade
kubectl delete ns argocd
minikube stop
```

---

✅ You now have a fully working CI/CD DevOps project with Kubernetes, Helm, Jenkins, ArgoCD, Git, and Maven.
