Commandes utilisées (construction et test)
1. Construction de l’image backend
>> docker build -t paymybuddy-backend ./backend
<img width="1318" height="675" alt="tpc1" src="https://github.com/user-attachments/assets/18e8b61a-d805-4677-8c35-914b622bb61d" />

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
