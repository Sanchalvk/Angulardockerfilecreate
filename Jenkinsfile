pipeline {
  agent any

  environment {
    SONARQUBE = 'SonarQubeServer' // your SonarQube server name in Jenkins config
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Install Dependencies') {
      steps {
        sh 'npm install'
      }
    }
    stage('Build Angular App') {
      steps {
        sh 'npm run build'
      }
    }
    stage('SonarQube Analysis') {
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
