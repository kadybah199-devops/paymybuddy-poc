# PayMyBuddy — Proof of Concept Docker

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=flat&logo=springboot&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL_8.0-4479A1?style=flat&logo=mysql&logoColor=white)

Déploiement conteneurisé d'une application Spring Boot + MySQL via Docker Compose et un Registry privé.

---

## Architecture

```
Utilisateur :8080
      │
      ▼
paymybuddy-backend (Spring Boot)
      │
      ▼
paymybuddy-db (MySQL 8.0 :3306)

localhost:5000 → Registry Docker privé
```

---

## Prérequis

- Docker ≥ 20.10
- Docker Compose ≥ 2.0

---

## Structure du projet

```
paymybuddy-poc/
├── Dockerfile                          # Image backend
├── docker-compose.yml                  # Orchestration des services
├── .env                                # Variables d'environnement (⚠️ ne pas committer)
├── .env.example                        # Modèle de configuration
├── target/
│   └── paymybuddy.jar                  # JAR Spring Boot
└── db/
    └── initdb/
        └── init.sql                    # Schéma MySQL (exécuté au 1er démarrage)
```

---

## Configuration

```bash
cp .env.example .env
```

| Variable | Description | Valeur par défaut |
|---|---|---|
| `MYSQL_DATABASE` | Nom de la base | `db_paymybuddy` |
| `MYSQL_USER` | Utilisateur MySQL | `paymybuddy` |
| `MYSQL_PASSWORD` | Mot de passe | `paymybuddy` |
| `SPRING_DATASOURCE_URL` | URL JDBC | `jdbc:mysql://paymybuddy-db:3306/db_paymybuddy` |

---

## Déploiement

### 1. Démarrer le Registry privé

```bash
docker compose up -d registry
```

### 2. Builder et pousser l'image

```bash
docker build -t localhost:5000/paymybuddy-backend:latest .
docker push localhost:5000/paymybuddy-backend:latest
```

### 3. Lancer tous les services

```bash
docker compose up -d
```

### 4. Vérifier

```bash
docker ps
```

```
CONTAINER ID   IMAGE                                      PORTS                    NAMES
xxxxxxxxxxxx   localhost:5000/paymybuddy-backend:latest   0.0.0.0:8080->8080/tcp   paymybuddy-backend
xxxxxxxxxxxx   mysql:8.0                                  0.0.0.0:3306->3306/tcp   paymybuddy-db
xxxxxxxxxxxx   registry:2                                 0.0.0.0:5000->5000/tcp   paymybuddy-registry
```

Application accessible sur : **http://localhost:8080**

---

## Screenshots

### docker ps — 3 conteneurs actifs
<img width="1019" height="304" alt="docker ps" src="https://github.com/user-attachments/assets/a578b6f6-f611-4754-a4ee-a27c0562c018" />


### Application PayMyBuddy
<img width="1347" height="673" alt="paymybuddy" src="https://github.com/user-attachments/assets/0dc58462-8f7d-4cb7-8ed3-bbb261cfa433" />


### Registry privé
<img width="1033" height="311" alt="registry" src="https://github.com/user-attachments/assets/9c7af4c2-0292-472d-a5e4-0eaf2afc3e63" />


---

## Commandes utiles

```bash
# Logs backend
docker logs paymybuddy-backend -f

# Vérifier les tables MySQL
docker exec -it paymybuddy-db mysql -u root -prootpassword db_paymybuddy -e "SHOW TABLES;"

# Vérifier le registry
curl http://localhost:5000/v2/_catalog

# Arrêter tout
docker compose down

# Arrêter et supprimer les volumes (réinitialise la DB)
docker compose down -v
```

