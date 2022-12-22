pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                script {
                    sh "docker build --no-cache -t lmnad_base:latest ."
                }
            }
        }
        stage('Deploy') {
            agent any
            environment { 
                ALLOWED_HOSTS = "['localhost', '127.0.0.1', '188.120.225.17']"
            }
            steps {
                load "env.groovy"
                sh "docker-compose -f docker-compose.dev.yml up -d"
            }
        }
    }
}
