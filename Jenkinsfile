pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                script {
                    sh "docker build --no-cache ."
                }
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'lmnad_base'
                }
            }
            steps {
                    sh "python manage.py test"
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
