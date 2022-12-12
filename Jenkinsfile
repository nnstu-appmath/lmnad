pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                script {
                    sh "docker build --no-cache -t lmnad_base:latest -f Dockerfile ."
                }
            }
        }
        stage('Test') {
            agent any
            steps {
                script {
                    sh "docker run --name testlmnad_base -p 8000:8000 lmnad_base:latest"
                }
            }
            agent {
                docker {
                    testlmnad_base
                {
            }
            steps {
                script {
                    sh "python manage.py test"
                }
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sh "docker-compose up -d"
            }
        }
    }
}
