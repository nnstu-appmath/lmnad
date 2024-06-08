pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.prod.local.yml'
        DJANGO_SECRET_KEY = 'prod_local'
        DJANGO_SETTINGS_MODULE = 'project.settings.server'
        DB_HOST = 'db'
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
        stage('Stop and Remove Containers') {
            steps {
                script {
                    sh """
                        docker stop lmnad_celery lmnad_nginx lmnad_flower lmnad_web lmnad_mysql lmnad_rabbitmq || true
                        docker rm lmnad_celery lmnad_nginx lmnad_flower lmnad_web lmnad_mysql lmnad_rabbitmq || true
                    """
                }
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'lmnad_jenkins', url: 'https://github.com/nnstu-appmath/lmnad'
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    // Пересборка образов и запуск контейнеров
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d --build"
                    
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
