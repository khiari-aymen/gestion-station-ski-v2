FROM openjdk:17-jdk-slim



EXPOSE 8082



ADD target/gestion-station-ski-1.2.3.jar achat-1.0.jar




ENTRYPOINT ["java", "-jar", "/achat-1.0.jar"]

 
