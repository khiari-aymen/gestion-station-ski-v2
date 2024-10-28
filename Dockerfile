FROM openjdk:17-jdk-slim
EXPOSE 8082
ADD target/gestion-station-ski-1.0.jar gestion-station-ski-1.0.jar
ENTRYPOINT ["java"."-jar","/gestion-station-ski-1.0.jar"]
