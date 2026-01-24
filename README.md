Commandes utilisées (construction et test)
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
