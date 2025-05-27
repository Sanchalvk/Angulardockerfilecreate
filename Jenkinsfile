pipeline {
  agent any

  environment {
    SONARQUBE = 'SonarQubeServer' // SonarQube server configured in Jenkins
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
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

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t my-angular-app .'
      }
    }

    stage('Run Docker Container') {
      steps {
        sh 'docker run -d -p 4200:80 my-angular-app'
      }
    }
  }
}
