pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.prod.local.yml'
        DJANGO_SECRET_KEY = 'prod_local'
        DJANGO_SETTINGS_MODULE = 'project.settings.server'
        DB_HOST = 'db_test'
        DB_USER = 'lmnad_prod_local'
        DB_PASSWORD = '12345'
        CELERY_BROKER_URL = 'amqp://guest:guest@broker:5672'
        CELERY_RESULT_BACKEND = 'rpc://'
        MYSQL_ROOT_HOST = '%'
        MYSQL_ROOT_PASSWORD = '78910'
        YANDEX_TRANSLATE_API_KEY = 'local'
        GEOPOSITION_GOOGLE_MAPS_API_KEY = 'local'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/esinkirill/lmnad-jenkins'
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    // Rebuild Docker containers without cache
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} build --no-cache"
                    // Start containers
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
