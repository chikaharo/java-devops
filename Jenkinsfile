pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }
    environment {
        SNQ = tool 'sonar-scanner'
    }
    stages {
        stage("compile") {
            steps {
                sh "mvn compile"
            }
        }
        stage("Unit-test") {
            steps {
                sh "mvn test"
            }
        }
        stage("Sonar-analysis") {
            steps {
                withSonarQubeEnv('sonarqube-1') {
                    sh ''' $SNQ/bin/sonar-scanner -Dsonar.projectName=taskmaster -Dsonar.projectKey=taskmaster -Dsonar.java.binaries=target '''
                }
            }
        }
    }
}