# Image de base imposée par le TP
FROM amazoncorretto:17-alpine

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copie du JAR du backend Spring Boot
COPY target/paymybuddy.jar app.jar

# Port exposé par l’application backend
EXPOSE 8080

# Commande de démarrage du backend
CMD ["java", "-jar", "app.jar"]

