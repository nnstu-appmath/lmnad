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
                DB_HOST = 'db'
                DB_USER = 'dev' 
                DB_PASSWORD = 'dev'
                CELERY_BROKER_URL = 'amqp://guest:guest@broker:5672'
                CELERY_RESULT_BACKEND = 'rpc://'
                MYSQL_ROOT_HOST = '%'
                MYSQL_ROOT_PASSWORD = 'root'
                MYSQL_DATABASE = 'lmnad_db'
                MYSQL_USER = 'dev'
                MYSQL_PASSWORD = 'dev'
                YANDEX_TRANSLATE_API_KEY = 'dev'
                GEOPOSITION_GOOGLE_MAPS_API_KEY = 'dev'  
                ALLOWED_HOSTS = 'localhost 127.0.0.1 188.120.225.17'
            }
            steps {
                sh "docker-compose up -f docker-compose.dev.yml -d"
            }
        }
    }
}
