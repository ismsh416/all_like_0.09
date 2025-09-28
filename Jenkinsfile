pipeline {
    agent {
        docker {
            image 'gradle:8.3-jdk17'  // Gradle + JDK 17
            args '-u root:root'        // optional if you need root permissions
        }
    }

    environment {
        IMAGE_NAME = "epicor-app"
        REGISTRY = "image-registry.openshift-image-registry.svc:5000"
        PROJECT = "ismailsh416-dev"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/epicor.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh './gradlew clean bootJar'
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                """
            }
        }

        stage('Push & Deploy') {
            steps {
                sh """
                    docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER}
                    docker push ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER}

                    oc project ${PROJECT}
                    oc set image deployment/${IMAGE_NAME} ${IMAGE_NAME}=${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER} --record || \
                    oc new-app ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER} --name=${IMAGE_NAME}
                    oc rollout status deployment/${IMAGE_NAME}
                """
            }
        }
    }
}
