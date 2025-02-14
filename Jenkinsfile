pipeline {
    agent {
        node {
            label 'node-agent'  // Utilisation de ton node-agent Jenkins
        }
    }

    environment {
        DOCKER_IMAGE = "joanisky/app-express"
        DOCKER_TAG = "latest"
        DOCKERHUB_CREDENTIALS = credentials('joanisky-dockerhub')
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

//         stage('Build Application') {
//             steps {
//                 sh 'npm run build'
//             }
//         }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'joanisky-dockerhub', url: '']) {
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
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
