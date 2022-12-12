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
        stage('Test') {
            agent {
                docker {
                    image 'lmnad_base'
                }
            }
            environment {
                DJANGO_SECRET_KEY = 'dev'
                DJANGO_SETTINGS_MODULE = 'project.settings.server'
                DB_HOST = 'db'
                DB_USER = 'dev'
                DB_PASSWORD = 'dev'
                CELERY_BROKER_URL = 'amqp://guest:guest@broker:5672'
                CELERY_RESULT_BACKEND = 'rpc://'
                YANDEX_TRANSLATE_API_KEY = 'dev'
                GEOPOSITION_GOOGLE_MAPS_API_KEY = 'dev'   
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
