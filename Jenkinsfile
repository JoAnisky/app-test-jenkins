pipeline {
    agent {
		node {
			label :'docker-general-agent'
		}
    }
    environment {
        DOCKER_IMAGE = "joanisky/app-express"
        DOCKER_TAG = "latest"
        REMOTE_USER = "toor"
        REMOTE_HOST = "147.93.89.90"
        DOCKERHUB_CREDENTIALS = credentials('joanisky-dockerhub')
    }

    stages {

        stage('Build Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."  // Correction : ajout du point pour le context
            }
        }

        stage('Login Docker Hub') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin>" // ou utiliser des credentials Jenkins
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
// 		stage('Deploy to Server') {
// 			steps {
// 				sshagent(['ssh-server-ci']) {
// 					sh '''
// 						ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST <<EOF
// 							docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
// 							docker-compose pull
// 							docker-compose up -d --force-recreate
// 							docker system prune -f
// 						EOF
// 					'''
// 				}
// 			}
// 		}
    }
    post {
        always {
            sh "docker logout"
        }
    }

}