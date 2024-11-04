FROM eclipse-temurin:17-jdk
EXPOSE 8089
ADD ./target/gestion-station-ski-1.0.12.jar gestion-station-ski-1.0.12.jar
ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.0.12.jar"]
