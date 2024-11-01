FROM openjdk:17-jdk-slim

EXPOSE 8082

ADD target/gestion-station-ski-1.0.9.jar gestion-station-ski.jar

ENTRYPOINT ["java", "-jar", "/gestion-station-ski.jar"]
