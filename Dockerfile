FROM eclipse-temurin:17-jdk

EXPOSE 8082

ADD target/gestion-station-ski-1.0.11.jar gestion-station-ski.jar

ENTRYPOINT ["java", "-jar", "/gestion-station-ski.jar"]
