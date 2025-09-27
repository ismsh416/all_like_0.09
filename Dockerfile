FROM registry.access.redhat.com/ubi8/openjdk-17
COPY target/epicor-0.0.1-SNAPSHOT.jar /deployments/app.jar
ENV JAVA_APP_JAR=/deployments/app.jar
CMD ["java", "-jar", "/deployments/app.jar"]
