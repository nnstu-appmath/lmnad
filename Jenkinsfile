pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                script {
                    sh "docker build -t lmnad_base:latest ."
                }
            }
        }
        stage('Deploy') {
            agent any
            environment { 
                load "dev.env"
                ALLOWED_HOSTS = 'localhost 127.0.0.1 188.120.225.17'
            }
            steps {
                sh "docker-compose -f docker-compose.dev.yml up -d"
            }
        }
    }
}
