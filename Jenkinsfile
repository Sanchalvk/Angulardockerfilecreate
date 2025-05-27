pipeline {
  agent any

  environment {
    SONARQUBE = 'SonarQubeServer'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/Sanchalvk/Angulardockerfilecreate.git'
      }
    }

    stage('Install Dependencies') {
      agent {
        docker { image 'node:16' }
      }
      steps {
        sh 'npm install'
      }
    }

    stage('Build Angular App') {
      agent {
        docker { image 'node:16' }
      }
      steps {
        sh 'npm run build'
      }
    }

    stage('SonarQube Analysis') {
      agent {
        docker { image 'node:16' }
      }
      steps {
        withSonarQubeEnv("${SONARQUBE}") {
          sh 'sonar-scanner'
        }
      }
    }

    stage('Quality Gate') {
      steps {
        timeout(time: 1, unit: 'HOURS') {
          waitForQualityGate abortPipeline: true
        }
      }
    }

    stage('Build Docker Image'
