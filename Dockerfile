<<<<<<< HEAD
FROM openjdk:17-jdk
=======
FROM eclipse-temurin:17-jdk

# Install MySQL client
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*
>>>>>>> e07e73e (besmeleh)

EXPOSE 8082

ADD target/gestion-station-ski-1.0.12.jar gestion-station-ski.jar

ENTRYPOINT ["java", "-jar", "/gestion-station-ski.jar"]
