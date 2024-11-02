FROM openjdk:17-jdk-slim
RUN apt-get update && apt-get install -y netcat && apt-get clean
EXPOSE 8089
ADD ./target/gestion-station-ski-1.2.5.jar gestion-station-ski-1.2.5.jar
ENTRYPOINT ["java", "-jar", "gestion-station-ski-1.2.5.jar"]
