# ============================================================
# Dockerfile — PayMyBuddy Backend
# Base image imposée par le TP
# ============================================================
FROM amazoncorretto:17-alpine

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copie du JAR buildé par Maven (depuis la racine du projet)
COPY target/paymybuddy.jar app.jar

# Port exposé par l'application Spring Boot
EXPOSE 8080

# Variables d'environnement pour la connexion à la base de données
# Ne pas hardcoder les credentials — injectées via .env au runtime
ENV SPRING_DATASOURCE_URL=""
ENV SPRING_DATASOURCE_USERNAME=""
ENV SPRING_DATASOURCE_PASSWORD=""

# Commande de démarrage du backend
CMD ["java", "-jar", "app.jar"]
