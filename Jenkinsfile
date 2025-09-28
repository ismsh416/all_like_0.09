pipeline {
    agent any

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

        stage('Build Docker Image') {
            steps {
                sh """
                    # Use Gradle wrapper (bundled with project)
                    ./gradlew clean bootJar

                    # Build Docker image
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
