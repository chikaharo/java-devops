pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        IMAGE_REPO = "dinhuy975"
        IMAGE_NAME = "boardgame"
        IMAGE_VER = "1.0.0"
    }
    stages {
        stage("compile") {
            steps {
                sh "mvn compile"
            }
        }
        stage("Unit test") {
            steps {
                echo "Testing maven app"
                // sh "mvn test"
            }
        }
        // stage("Trivy scan") {
        //     steps {
        //         sh "trivy fs --format -o fs.html"
        //     }
        // }
        stage("Sonar analysis") {
            steps {
                // withSonarQubeEnv('sonarqube-1') {
                //     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=taskmaster -Dsonar.projectKey=taskmaster -Dsonar.java.binaries=target '''
                // }
                withSonarQubeEnv(credentialsId: 'sonar-token', installationName: 'sonarqube-1') { // You can override the credential to be used, If you have configured more than one global server connection, you can specify the corresponding SonarQube installation name configured in Jenkins
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.11.0.3922:sonar'
                }
            }
        }
        stage("Build docker image") {
            steps {
                sh "docker build -t ${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_VER} ."
            }
        }
        stage("Push docker image") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-crendentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
 
                        // Push the image
                        sh "docker push ${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_VER}"
                    }
                }
            }
        }
        stage("Trivy scan docker image") {
            steps {
                script {
                    def trivyRes = sh("docker run -v /var/run/docker.sock trivy image ${IMAGE_REPO}/${IMAGE_NAME}:${IMAGE_VER}", returnStdout: true).trim()
                    println trivyRes
                    if (trivyRes.contain("Total: 0")) {
                        echo "No vulnerability has found"
                    } else {
                        echo "There are some vulnerability errors"
                    }
                }
            }
        }
    }
}
