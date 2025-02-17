pipeline {
    agent {
        node {
            label 'node-agent'  // Utilisation du Node Docker Agent de mon repo Docker Hub
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express"
        DOCKER_TAG = "latest"
        APP_DIR = "/home/toor/app"  // Dossier où l'app sera stockée
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
			   sshagent(['ssh-toor']) {
				  sh """
						ssh -o StrictHostKeyChecking=no toor@147.93.89.90
					   	scp -r * toor@147.93.89.90:${APP_DIR}
					   	ssh toor@147.93.89.90 '/home/toor/deploy-docker.sh ${APP_DIR} ${DOCKER_IMAGE} ${DOCKER_TAG}'
				   """
			   }
            }
        }

    }
}
