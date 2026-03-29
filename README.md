# PayMyBuddy — Proof of Concept

Déploiement conteneurisé d'une application Spring Boot + MySQL via Docker et Docker Registry privé.

---

## Architecture

```
┌─────────────────────────┐        ┌──────────────────────────┐
│  paymybuddy-backend     │──────▶ │  paymybuddy-db           │
│  Spring Boot :8080      │        │  MySQL 8.0 :3306         │
└─────────────────────────┘        └──────────────────────────┘
```

- **Backend** : image `amazoncorretto:17-alpine` + JAR Spring Boot
- **Base de données** : MySQL 8.0 avec initialisation automatique du schéma
- **Réseau** : le backend attend que la DB soit prête (`healthcheck`) avant de démarrer

---

## Prérequis

- Docker ≥ 20.10
- Docker Compose ≥ 2.0

> Sur une VM Vagrant, ajouter l'utilisateur au groupe docker :
> ```bash
> sudo usermod -aG docker vagrant && newgrp docker
> ```

---

## Configuration

Copier le fichier d'exemple et ajuster si besoin :

```bash
cp .env.example .env
```

Les variables disponibles :

| Variable                    | Description                              | Valeur par défaut                              |
|-----------------------------|------------------------------------------|------------------------------------------------|
| `MYSQL_ROOT_PASSWORD`       | Mot de passe root MySQL                  | `rootpassword`                                 |
| `MYSQL_DATABASE`            | Nom de la base de données                | `paymybuddy`                                   |
| `MYSQL_USER`                | Utilisateur applicatif MySQL             | `paymybuddy`                                   |
| `MYSQL_PASSWORD`            | Mot de passe de l'utilisateur            | `paymybuddy123`                                |
| `SPRING_DATASOURCE_URL`     | URL JDBC du backend                      | `jdbc:mysql://paymybuddy-db:3306/paymybuddy`   |
| `SPRING_DATASOURCE_USERNAME`| Login Spring Boot                        | `paymybuddy`                                   |
| `SPRING_DATASOURCE_PASSWORD`| Mot de passe Spring Boot                 | `paymybuddy123`                                |

---

## Déploiement local

### 1. Construction de l'image backend

```bash
docker build -t paymybuddy-backend ./backend
```

### 2. Lancement de l'infrastructure complète

```bash
docker compose up -d
```

Le backend attend automatiquement que MySQL soit disponible grâce au `healthcheck` défini dans `docker-compose.yml`.

### 3. Vérification des conteneurs

```bash
docker ps
```

### 4. Consultation des logs

```bash
# Logs du backend Spring Boot
docker logs paymybuddy-backend

# Logs de la base de données
docker logs paymybuddy-db
```

---

## Docker Registry privé

### Déploiement du registre local

```bash
docker run -d -p 5000:5000 --name registry registry:2
```

### Tag et push de l'image backend

```bash
docker tag paymybuddy-backend localhost:5000/paymybuddy-backend
docker push localhost:5000/paymybuddy-backend
```

### Utilisation de l'image depuis le registre

Dans `docker-compose.yml`, remplacer :

```yaml
image: paymybuddy-backend
```

par :

```yaml
image: localhost:5000/paymybuddy-backend
```

---

## Structure du projet

```
paymybuddy-poc/
├── .env                    # Variables d'environnement (à ne pas committer)
├── .env.example            # Modèle de configuration
├── docker-compose.yml      # Orchestration des services
├── backend/
│   ├── Dockerfile          # Image Spring Boot (amazoncorretto:17-alpine)
│   └── target/
│       └── paymybuddy.jar  # JAR pré-compilé
└── db/
    └── initdb/
        └── init.sql        # Initialisation du schéma MySQL
```

---

## Arrêt et nettoyage

```bash
# Arrêter les conteneurs
docker compose down

# Arrêter et supprimer les volumes (réinitialise la BDD)
docker compose down -v
```

Commandes utilisées 
1. Construction de l’image backend
>> docker build -t paymybuddy-backend ./backend
<img width="1318" height="675" alt="tpc1" src="https://github.com/user-attachments/assets/18e8b61a-d805-4677-8c35-914b622bb61d" />

Lancement de l’infrastructure complète
>> docker compose up -d
<img width="1350" height="717" alt="tpc2" src="https://github.com/user-attachments/assets/80ec827d-60e1-42fe-9b48-1492ebb60ad0" />

Vérification des conteneurs
>> docker ps
<img width="1337" height="701" alt="tpc3" src="https://github.com/user-attachments/assets/c18b874a-37b1-4aa4-bd67-016a62374d6b" />

Consultation des logs
>> docker logs paymybuddy-backend
>> docker logs paymybuddy-db
<img width="1142" height="428" alt="tcp4" src="https://github.com/user-attachments/assets/1dbffbbf-3a77-4c9a-a4ca-0ccfb565e8cb" />
     -- donner les droit a l'utilisateur vagrant comme la machine virtuelle est creer par vagrant: newgrp docker vagrant
2.  Docker Registry
Déploiement du registre privé
>> docker run -d -p 5000:5000 --name registry registry:2
<img width="1220" height="458" alt="tcp5" src="https://github.com/user-attachments/assets/04ccc664-f6be-4604-a3dc-5ea85123dcc3" />

Tag de l’image backend
>> docker tag paymybuddy-backend localhost:5000/paymybuddy-backend
<img width="1141" height="447" alt="tag" src="https://github.com/user-attachments/assets/8f675f61-1c6f-445e-ac27-bb269fceebd5" />

Push vers le registre privé
>> docker push localhost:5000/paymybuddy-backend
<img width="1346" height="674" alt="push" src="https://github.com/user-attachments/assets/1452fe19-0396-4ae5-846f-6d9231c2903b" />

Utilisation de l’image depuis le registre

Dans docker-compose.yml :

image: localhost:5000/paymybuddy-backend
