FROM registry.access.redhat.com/ubi8/openjdk-17

COPY target/epicor-0.0.1-SNAPSHOT.jar /deployments/

ENV JAVA_APP_JAR=epicor-0.0.1-SNAPSHOT.jar

