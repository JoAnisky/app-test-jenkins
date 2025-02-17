pipeline {
    agent {
        node {
            label 'node-agent'  // Utilisation du Node Docker Agent de mon repo Docker Hub
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express"  // nom de l'image a pousser sur DockerHub
        DOCKER_TAG = "latest"
        APP_DIR = "${HOME_DIR}/app"  // Dossier où l'app sera stockée
    }

    stages {
        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'joanisky-dockerhub') {
                        def customImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                withCredentials([
                    string(credentialsId: 'ssh-user', variable: 'SSH_USER'),
                    string(credentialsId: 'ssh-url', variable: 'SSH_URL'),
                    string(credentialsId: 'home-dir', variable: 'HOME_DIR')
                ]) {
                    // Commandes SSH sécurisées avec les credentials
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_URL}
                        scp -r * ${SSH_USER}@${SSH_URL}:${APP_DIR}
                        ssh ${SSH_USER}@${SSH_URL} '${HOME_DIR}/scripts/deploy-docker.sh ${APP_DIR} ${DOCKER_IMAGE} ${DOCKER_TAG}'
                    """
                }
            }
        }
    }
}
