pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
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
                // withSonarQubeEnv('sonarqube-1') {
                //     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=taskmaster -Dsonar.projectKey=taskmaster -Dsonar.java.binaries=target '''
                // }
                withSonarQubeEnv(credentialsId: 'sonar-token', installationName: 'sonarqube-1') { // You can override the credential to be used, If you have configured more than one global server connection, you can specify the corresponding SonarQube installation name configured in Jenkins
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.11.0.3922:sonar'
                }
            }
        }
    }
}
