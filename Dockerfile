# Stage 1: build with Gradle & JDK 17
FROM gradle:8.3-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle clean bootJar --no-daemon

# Stage 2: runtime
FROM registry.access.redhat.com/ubi8/openjdk-17
COPY --from=builder /app/build/libs/*.jar /deployments/app.jar
ENV JAVA_APP_JAR=/deployments/app.jar
CMD ["java", "-jar", "/deployments/app.jar"]