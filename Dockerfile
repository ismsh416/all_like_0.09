# Stage 1: Build the JAR inside Docker (so Jenkins doesn't need Gradle locally)
FROM gradle:8.3-jdk17 AS builder

WORKDIR /app

# Copy Gradle config first to cache dependencies
COPY build.gradle settings.gradle ./

# Copy source code
COPY src ./src

# Build the fat JAR
RUN gradle clean bootJar --no-daemon

# Stage 2: Runtime
FROM registry.access.redhat.com/ubi8/openjdk-17

# Copy the JAR from the builder stage
COPY --from=builder /build/libs/demo-0.0.1-SNAPSHOT.jar /deployments/app.jar

ENV JAVA_APP_JAR=/deployments/app.jar

CMD ["java", "-jar", "/deployments/app.jar"]
