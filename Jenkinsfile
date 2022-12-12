pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                script {
                    sh "docker build --no-cache -t lmnad_base -f Dockerfile ."
                }
            }
        }
        stage('Run') {
            agent any
            steps {
                script {
                    sh "docker run lmnad_base"
                }
            }
        }
        stage('Test') {
            agent {
                docker {
                    container lmnad_base
                }
            }
            steps {
                sh 'python manage.py test'
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
