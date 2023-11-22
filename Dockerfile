FROM openjdk:11-jre-slim
WORKDIR /app
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "/app/app.jar", "--server.port=8000"]