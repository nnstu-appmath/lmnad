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
                DJANGO_SECRET_KEY = '${DJANGO_SECRET_KEY}'
                DJANGO_SETTINGS_MODULE = '${DJANGO_SETTINGS_MODULE}'
                DB_HOST = '${DB_HOST}'
                DB_USER = '${DB_USER}'
                DB_PASSWORD = '${DB_PASSWORD}'
                CELERY_BROKER_URL = '${CELERY_BROKER_URL}'
                CELERY_RESULT_BACKEND = '${CELERY_RESULT_BACKEND}'
                YANDEX_TRANSLATE_API_KEY = '${YANDEX_TRANSLATE_API_KEY}'
                GEOPOSITION_GOOGLE_MAPS_API_KEY = '${GEOPOSITION_GOOGLE_MAPS_API_KEY}'   
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
