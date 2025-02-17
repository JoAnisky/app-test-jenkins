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

                        ssh toor@147.93.89.90 'mkdir -p ${APP_DIR}'

                        scp -r * toor@147.93.89.90:${APP_DIR}

                        echo '
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                        cd ${APP_DIR}
                        docker-compose down
                        docker-compose up -d --force-recreate
                        docker system prune -f
                        ' > deploy.sh

                        scp deploy.sh toor@147.93.89.90:/home/toor/

                        ssh toor@147.93.89.90 'bash /home/toor/deploy.sh'

                        ssh toor@147.93.89.90 'rm /home/toor/deploy.sh'
                    """
                }
            }
        }

    }
}
