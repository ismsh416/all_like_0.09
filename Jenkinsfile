pipeline {
    agent any

    environment {
        IMAGE = "image-registry.openshift-image-registry.svc:5000/ismailsh416-dev/epicor-app"
        OC_PROJECT = "ismailsh416-dev"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR with Gradle') {
            steps {
                sh './gradlew clean bootJar'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE}:${BUILD_NUMBER} .'
            }
        }

        stage('Push to OpenShift Registry') {
            steps {
                sh '''
                    oc whoami -t | docker login -u openshift --password-stdin \
                      image-registry.openshift-image-registry.svc:5000
                    docker push ${IMAGE}:${BUILD_NUMBER}
                '''
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                sh '''
                    oc project ${OC_PROJECT}
                    oc set image deployment/epicor-app epicor-app=${IMAGE}:${BUILD_NUMBER} || \
                    oc create deployment epicor-app --image=${IMAGE}:${BUILD_NUMBER}
                    oc expose svc/epicor-app || true
                    oc rollout status deployment/epicor-app
                '''
            }
        }
    }
}
