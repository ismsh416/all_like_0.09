pipeline {
    agent any

    environment {
        PROJECT = "ismailsh416-dev"
        APP_NAME = "epicor-app"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your branch
                git branch: 'master', url: 'https://github.com/ismsh416/all_like_0.09.git'
            }
        }

        stage('Build JAR') {
            steps {
                // Use Gradle wrapper to build the JAR
                sh './gradlew clean bootJar'
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                // Start S2I build in OpenShift with the JAR
                sh """
                oc project ${PROJECT}

                # Check if BuildConfig exists, create if missing
                if ! oc get bc ${APP_NAME} >/dev/null 2>&1; then
                    oc new-build registry.access.redhat.com/ubi8/openjdk-17 --binary --name=${APP_NAME}
                fi

                # Start build from the generated JAR
                oc start-build ${APP_NAME} --from-file=build/libs/epicor-0.0.1-SNAPSHOT.jar --follow

                # Deploy or rollout the application
                if ! oc get deployment ${APP_NAME} >/dev/null 2>&1; then
                    oc new-app ${APP_NAME} --name=${APP_NAME}
                else
                    oc rollout latest deployment/${APP_NAME}
                fi
                """
            }
        }
    }

    post {
        success {
            echo "Build and deployment completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
