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
                DB_PASSWORD = 'dev'
                CELERY_BROKER_URL = 'amqp://guest:guest@broker:5672'
                CELERY_RESULT_BACKEND = 'rpc://'
                MYSQL_DATABASE = 'lmnad_db'
                MYSQL_USER = 'dev'
                MYSQL_PASSWORD = 'dev'
                YANDEX_TRANSLATE_API_KEY = 'dev'
                GEOPOSITION_GOOGLE_MAPS_API_KEY = 'dev'  
            }
            steps {
                sh "docker-compose up -d"
            }
        }
    }
}
