# ✅ Base image: OpenJDK 17 + Gradle
FROM gradle:8.2.1-jdk17 AS build
COPY --chown=gradle:gradle . /app
WORKDIR /app

# ✅ Build the application
RUN gradle build -x test

# ✅ Production image
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

# ✅ Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
