pipeline {
  agent any
  stages {
    stage('Build') {
      steps { sh 'mvn clean package -f backend/pom.xml' }
    }
    stage('Docker Build & Push') {
      steps {
        sh 'docker build -t breakout-trade-frontend:latest frontend/' }
        sh 'docker build -t breakout-trade-backend:latest backend/' }
    }
    stage('Deploy to K8s') {
      steps {
        sh 'helm upgrade --install breakout-trade k8s/helm/breakout-trade/' }
    }
  }
}