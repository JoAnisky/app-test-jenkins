pipeline {
    agent {
        node {
            label 'node-docker-agent'  // Utilisation du Node Docker Agent de mon repo Docker Hub
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express"
        DOCKER_TAG = "latest"
    }
	stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'joanisky-dockerhub') {
                        def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                        image.push()
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").remove()
                }
            }
        }

//         stage('Deploy to Production') {
//             steps {
//                 sshagent(['ssh-server-ci']) {
//                     sh """
//                         ssh -o StrictHostKeyChecking=no toor@147.93.89.90 <<EOF
//                             docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
//                             docker-compose down
//                             docker-compose up -d --force-recreate
//                             docker system prune -f
//                         EOF
//                     """
//                 }
//             }
//         }
    }
}
