pipeline {
    agent {
        node {
            label 'node-agent'  // Utilisation du Node Docker Agent de mon repo Docker Hub
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express"
        DOCKER_TAG = "latest"
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
                sshagent(['ssh-server-ci']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no toor@147.93.89.90 <<EOF
                            docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                            docker-compose down
                            docker-compose up -d --force-recreate
                            docker system prune -f
                        EOF
                    """
                }
            }
        }

    }
}
