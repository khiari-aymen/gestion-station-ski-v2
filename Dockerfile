FROM eclipse-temurin:17-jdk
# Exposer le port
EXPOSE 8089

# Ajouter le fichier JAR
ADD ./target/gestion-station-ski-1.8.jar gestion-station-ski-1.8.jar

# Point d'entrée de l'application
ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.8.jar"]

