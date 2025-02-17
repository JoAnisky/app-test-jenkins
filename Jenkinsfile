pipeline {
    agent {
        node {
            label 'node-agent'  // Utilisation du Node Docker Agent de mon repo Docker Hub
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express" // nom de l'image a pousser sur DockerHub
        DOCKER_TAG = "latest"
		APP_DIR = "${HOME_DIR}/app"  // Dossier où l'app sera stockée
		SSH_USER = credentials('ssh-user')  // Récupère l'utilisateur SSH stocké dans Jenkins
		SSH_URL = credentials('ssh-url')  // Récupère l'URL SSH
		HOME_DIR = credentials('home-dir')  // Récupère le chemin HOME
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
                withCredentials([usernamePassword(credentialsId: 'ssh-user', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASSWORD')]) {
                    // SSH command with secured credentials
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
