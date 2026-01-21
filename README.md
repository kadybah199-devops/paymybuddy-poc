Commandes utilisées (construction et test)
1. Construction de l’image backend
>> docker build -t paymybuddy-backend ./backend

Lancement de l’infrastructure complète
>> docker compose up -d

Vérification des conteneurs
>> docker ps

Consultation des logs
>> docker logs paymybuddy-backend
>> docker logs paymybuddy-db

2.  Docker Registry
Déploiement du registre privé
>> docker run -d -p 5000:5000 --name registry registry:2

Tag de l’image backend
>> docker tag paymybuddy-backend localhost:5000/paymybuddy-backend

Push vers le registre privé
>> docker push localhost:5000/paymybuddy-backend

Utilisation de l’image depuis le registre

Dans docker-compose.yml :

image: localhost:5000/paymybuddy-backend
