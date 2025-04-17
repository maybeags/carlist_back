# # ✅ Base image: OpenJDK 17 + Gradle
# FROM gradle:8.2.1-jdk17 AS build
# COPY --chown=gradle:gradle . /app
# WORKDIR /app
#
# # ✅ Build the application
# RUN gradle build -x test
#
# # ✅ Production image
# FROM eclipse-temurin:17-jre
# WORKDIR /app
# COPY --from=build /app/build/libs/*.jar app.jar
#
# # ✅ Run the JAR
# ENTRYPOINT ["java", "-jar", "app.jar"]

# ✅ Base: Gradle + JDK 17
FROM gradle:8.2.1-jdk17 AS build
COPY --chown=gradle:gradle . /app
WORKDIR /app

# ✅ Optional: 캐시 최적화 전략 (있으면 좋음)
# COPY --chown=gradle:gradle build.gradle settings.gradle /app/
# RUN gradle dependencies

RUN gradle build -x test

# ✅ Runtime: 경량 JRE
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/app.jar app.jar

# ✅ 포트 오픈 (Render 필수)
EXPOSE 8080

# ✅ 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
