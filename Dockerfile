FROM eclipse-temurin:17-jdk
EXPOSE 8089
ADD ./target/gestion-station-ski-2.0.5.jar gestion-station-ski-2.0.5.jar
ENTRYPOINT ["java", "-jar", "gestion-station-ski-2.0.5.jar"]
