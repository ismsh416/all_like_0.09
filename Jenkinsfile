pipeline {
    agent any

    environment {
        IMAGE_NAME = "epicor-app"
        PROJECT = "ismailsh416-dev"
        REGISTRY = "image-registry.openshift-image-registry.svc:5000"
    }

    stages {
        stage('Checkout') {
            steps {
                // Make sure this matches your branch: master or main
                git branch: 'master', url: 'https://github.com/ismsh416/all_like_0.09.git'
            }
        }

        stage('Build JAR') {
            steps {
                // Use Gradle wrapper; it ensures JDK 17 from your build system
                sh './gradlew clean bootJar'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                """
            }
        }

        stage('Push & Deploy to OpenShift') {
            steps {
                sh """
                    # Login to OpenShift registry (assumes 'oc login' done in Jenkins pod)
                    docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER}
                    docker push ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER}

                    # Deploy to OpenShift project
                    oc project ${PROJECT}
                    # Update deployment if exists, otherwise create a new one
                    oc set image deployment/${IMAGE_NAME} ${IMAGE_NAME}=${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER} --record || \
                    oc new-app ${REGISTRY}/${PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER} --name=${IMAGE_NAME}
                    oc rollout status deployment/${IMAGE_NAME}
                """
            }
        }
    }

    post {
        success {
            echo "Build & Deployment completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs."
        }
    }
}
