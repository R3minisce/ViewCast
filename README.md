# ViewCast

## _Sharing together_

ViewCast est une solution facilement déployable permettant l'administration des écrans connectés d'une entreprise.

## Technologies utilisées

- [MySQL] - base de données
- [python] & [fastAPI] - API
- [node] - orchestrator
- [flutter] - application web

## Déploiement

> Envirronement

Rendez vous sur le site de [ubuntu] et sélectionnez l'option 2 afin de faire une installation manuelle d'***Ubuntu server 20.04.3 LTS***.

**Suivez la procédure d'installation standard**
  
---

### Partie 1 : récupération du projet git

> Clonez le projet viewcast et déplacez-vous dans le répertoire viewcast avec les commandes suivantes :

```sh
sudo git clone https://gitlab.com/DTM-Henallux/MASI/etudiants/streignard-remi/web/viewcast.git
```

**A ce stage, introduisez votre nom d'utilisateur gitlab ainsi que le mot de passe correspondant à l'utilisateur ... sans vous tromper (:**

---

### Partie 2 : compilation du projet

> Installez flutter

```sh
sudo snap install flutter --classic
```

> Vérifiez si flutter est bien installé

```sh
sudo flutter
```

> Déplacez-vous dans le dossier du projet

```sh
cd viewcast
```

> Modifiez l'apiIP ( ligne 1 ) du fichier suivant par l'IP de la machine sur laquelle vous installer les services.

```sh
sudo nano Applications/viewcast/lib/services/api_config.dart
```

> Déplacez-vous dans le dossier de l'application web

```sh
cd Applications/viewcast
```

> Compilez viewcast en version web

```sh
sudo flutter build web
```

---

### Partie 3 : déployer le projet

> Installez docker 

```sh
sudo snap install docker
```

> Déplacez-vous dans le dossier du projet

```sh
cd ../..
```


> Créez l'entièreté de la stack viewcast avec la commande suivante : 

```sh
sudo docker-compose -p viewcast up -d
```

**Une fois la stack créée, attendez 20 secondes que l'ensemble des machines se démarrent correctement**

---

### Partie 4 : initialiser le client web

> Finalement, Créez votre utilisateur root ( administrateur ) avec la commande suivante :

**!! N'oubliez pas de changer les variables USERNAME EMAIL & PASSWORD par vos propres informations !!**

- **Le champ USERNAME doit être d'une longueure minimale de 5 caractères**

- **Le champ EMAIL doit être dans format correspondant à un email : example@example.ex**

- **Le champ PASSWORD doit contenir au minimum 12 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial**

```sh
    curl -X 'POST' \
    'http://localhost:8887/user/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "username": "USERNAME",
    "email": "EMAIL",
    "password": "PASSWORD",
    "admin": true,
    "groups_ids": [
    ]
    }'
```

Dans le cas d'une réussite, vous recevrez une réponse de l'API contenant votre UUID !

Rendez vous ensuite sur l'IP de votre serveur au port 8888.

Vous pourrez vous connectez à la partie administration avec vos identifiants.


   [mysql]: <https://www.mysql.com/fr/>
   [python]: <https://www.python.org/>
   [fastapi]: <https://fastapi.tiangolo.com/>
   [node]: <https://nodejs.org/en/>
   [flutter]: <https://flutter.dev/>
   [ubuntu]: <https://ubuntu.com/download/server>