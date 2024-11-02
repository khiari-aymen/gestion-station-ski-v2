FROM openjdk:17-jdk-slim

# Installez netcat pour vérifier la connectivité
RUN apt-get update && apt-get install -y netcat && apt-get clean

# Exposer le port de l'application
EXPOSE 8082

# Ajouter le fichier JAR à l'image
ADD target/gestion-station-ski-1.1.8.jar gestion-station-ski-1.1.8.jar

# Point d'entrée pour démarrer l'application
ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.1.8.jar"]
