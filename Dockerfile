FROM eclipse-temurin:17-jdk

# Installer le client MySQL
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*

EXPOSE 8089

# Ajouter le fichier JAR de votre application
ADD ./target/gestion-station-ski-1.2.7.jar gestion-station-ski-1.2.7.jar

# Définir le point d'entrée pour exécuter votre application
ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.2.7.jar"]

