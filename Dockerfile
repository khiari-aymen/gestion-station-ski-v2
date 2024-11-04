FROM openjdk:17-jdk-slim

# Installez le client MySQL
RUN apt-get update && apt-get install -y default-mysql-client

# Copiez le fichier JAR dans l'image
COPY ./target/gestion-station-ski-1.1.0.jar /gestion-station-ski-1.1.0.jar

# Commande par défaut pour exécuter l'application
ENTRYPOINT ["java", "-jar", "/gestion-station-ski-1.1.0.jar"]

